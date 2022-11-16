Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7FB62B6E0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiKPJsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiKPJsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:48:08 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A8A616E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:48:01 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 205so5823358ybe.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csie-ntu-edu-tw.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mTORVN+vb4ThEpVx7AxMit72NMXnsKSRAUOh1o/a8os=;
        b=iu183/XFyyYXhzOM/zCv5oVLc0dNPc63N8nAumxBq/E9DEFMaXcMVFjPQ8RwSk95QN
         qPwzLXSSx8g02xKSE2HH+0qsqSQCjwfSCzXWlPyjEt/GMuVRrUs4M66m6Cu0X5AQXy4f
         grx1TUGxOlGHdm36mCX0F436ljRJmlrugQFJE/7SgB9QyklFPlaZwbUq3IlCTAOCpwd/
         F26ekdEMZKT7QmX+J3Gkt/LyfFZI6fOtWtkqbWHCQT2Kj2v9bB/AlCunfzrwmdXqAIg4
         Mej0KEH0pinOfwJGOzYHS5tFfxdnFPQchC2uhzzBaANzkXA5ZF/2zY6zPgpj5XzyFdX0
         cc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTORVN+vb4ThEpVx7AxMit72NMXnsKSRAUOh1o/a8os=;
        b=SJvyG0PV2hAuiHXay0cBbRQ0D5d0maErNGPvo3dlZMtg+VNTZumDk2+LMMmwTVBb25
         eGj4mmPKTLhgZ0tOgpW/UMOZTQPIVoMC3Wt/9JLFBkiYsIof43sQlBl9nwMMfbX2xiEJ
         /G2z1jL8BGRDSHmbhot/Q61RHSB7e7QVc9d/UjqtDIgfURPLqf/4QzWEtCiQr8N7DLJQ
         UKzSRxxEzl8rMLXjndxNMo907FJTkxmjHqoGpkeOe+ydNayPZwLTN0jyZmyq63Uvkdc4
         3RIiIpmrgH7P/PA702Buxtt4fNAUg1aygKjzONl/5WKqJi45gg/C0WyF7VXWxsWFs3xR
         Ru5w==
X-Gm-Message-State: ANoB5pmaOI0Q7rPDRmiKpkW2llom9CaBbGUaDwJu+XS0ofZQYx2Jsrmf
        +XmVgfVuv1f0RWFWmX4kSBkNQcjQb/l+ThXzzfmQ08k+zzW5OKq8yk3P5hxynmnXtTjsjS4M0SD
        UQCPd9nsCEBjz8DOaBcNfTG0RjXq//WPccNxvxO4s3uKc4BBMlER0m9qzKGmTR3HDGmkiF/Ek+A
        XQhDPGBPyV2/JVhsfHOUY4DUcsYEb0TqOHogfZkITE25Q=
X-Google-Smtp-Source: AA0mqf5LPJHOIlXR/n5HkFhpXmP9htXFS+/vEYllOxnCYgoAQzNsF/+mL8haFdY/qJv+WVKacahqx8L+Nyvl6l+bD2g=
X-Received: by 2002:a25:7757:0:b0:6dd:ff71:f26c with SMTP id
 s84-20020a257757000000b006ddff71f26cmr20724110ybc.120.1668592081122; Wed, 16
 Nov 2022 01:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20221103053228.961591-1-r09922117@csie.ntu.edu.tw> <86fseppiqt.wl-maz@kernel.org>
In-Reply-To: <86fseppiqt.wl-maz@kernel.org>
From:   =?UTF-8?B?56ug55GL6bqf?= <r09922117@csie.ntu.edu.tw>
Date:   Wed, 16 Nov 2022 17:48:00 +0800
Message-ID: <CAM+=qvOKDeXcaxBUh9aAGbcQaLiiur=jui_EgwNzksopik_LzA@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Update comment of create_hyp_mappings
To:     Marc Zyngier <maz@kernel.org>
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, oliver.upton@linux.dev,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 12:18 AM Marc Zyngier <maz@kernel.org> wrote:
> My problem with this comment is that neither va_mask, tag_val, nor
> tag_lsb mean anything in this context. All this is purely internal to
> kvm_compute_layout(), and is unnecessary here.
>
> I'd rather you have something along the lines of:
>
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 60ee3d9f01f8..6d04818a1a5b 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -460,7 +460,7 @@ void kvm_unshare_hyp(void *from, void *to)
>   * @prot:      The protection to be applied to this range
>   *
>   * The same virtual address as the kernel virtual address is also used
> - * in Hyp-mode mapping (modulo HYP_PAGE_OFFSET) to the same underlying
> + * in Hyp-mode mapping (modulo a random offset) to the same underlying
>   * physical pages.
>   */
>  int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
>
> Whoever is interested in understanding the generation of the offset
> can follow kern_hyp_va().

Yes I agree, thanks for the advice.
I'll update the patch.

Wei-Lin Chang
