Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52B76C5124
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjCVQrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjCVQrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:47:37 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8D164272;
        Wed, 22 Mar 2023 09:47:27 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so9205610pjb.4;
        Wed, 22 Mar 2023 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679503647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LpONkzfOzhTH79tK5TxGy1m6Rwb93Q8fXC1hWk39Vlo=;
        b=QZ74OaqlkD8zv1ghDdRVHqbYtIVJxdWOejZN3IRVc13BcoaHHu7WOc16YXD2zQyV4B
         0cl2WTs0ldoNqvchBYj/ZDanw7IADbQreZVGvrxPUym5lhoZh+ukrIhiQOkfjN1A1rUM
         nrx/3BYXbRlP4rM5hQzWYD8kkPCCICAKQAB5YQ+jLRxoPiB9beaNbkTHjwnqTqVq2kO/
         23NmQs6x5Mgut3EqSh/88uXcqkjuB/cdu2wvdBss+jRRDtNv83ihe9YzvjEff/dnof05
         FJxbqL24n7birT6QRqMAQGRhMWlQZ4nga1QxdO77PGtAdgQpqh8DnNvdkXh6yYnuOF6j
         hDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679503647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpONkzfOzhTH79tK5TxGy1m6Rwb93Q8fXC1hWk39Vlo=;
        b=hfTnapF/1yHlaCasPizoKb7C9rQ+4rfoWGWULYU/18FQX+pPP9N7w0/dkR2M5sZ4Eq
         gCO44T6LEYTtG09BJapzwxDtDB4SCxZ5g9flVlmnjwxRoHK/vkU2EYy2tDTRb2c12ZZz
         n1DkikSZ5x/gr1+XfRlOT9bMQ823gUVajURKwQ6KY1x8Kia0J+WHEz8C5BaiHOA/T6Oy
         qw3VKrwSw9Yrn2EsmoDgXtU0rvSEd+1tdCgdIFDm5jICfjACVXBNaAID4mqWO+90b4IS
         jeWVmdJorP4xi+j53hHp2qQ5XFU/cfVY4mhmUFjfQ0EI7qtjcKtOVPNtUzBlExA7SyO9
         //LA==
X-Gm-Message-State: AO0yUKVR7oDE7iJVIxNbLHzPKNW4VmA4DpI+r5Pu33n2Hk1qP3RwQ8LD
        fQ+bOvxPmuEyGnMRPF3i95A=
X-Google-Smtp-Source: AK7set/mhxHpN1/DAuFzM8ChAXJD4RHuoL4I8fCe6g1mrgeIZ6Qdiok4c8utR0sUrA90kIXjfOLgwA==
X-Received: by 2002:a17:903:2301:b0:1a1:8fd4:251 with SMTP id d1-20020a170903230100b001a18fd40251mr3487080plh.55.1679503647254;
        Wed, 22 Mar 2023 09:47:27 -0700 (PDT)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c20600b0019b089bc8d7sm10898239pll.78.2023.03.22.09.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:47:26 -0700 (PDT)
Date:   Thu, 23 Mar 2023 00:47:18 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/4] arm64: dts: qcom: move elish dts to common dtsi
Message-ID: <ZBsxFh2qH6hv2Wo1@Gentoo>
References: <20230322150320.31787-1-lujianhua000@gmail.com>
 <2cb5fca2-56bc-c706-912b-2b8eaf7b3b94@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cb5fca2-56bc-c706-912b-2b8eaf7b3b94@linaro.org>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 05:32:06PM +0100, Krzysztof Kozlowski wrote:
> On 22/03/2023 16:03, Jianhua Lu wrote:
> > There are two panel variants of xiaomi-elish, BOE and CSOT panel.
> > In order to support both panels, so move elish dts to common dtsi.
> > 
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> > ---
> >  ...m8250-xiaomi-elish.dts => sm8250-xiaomi-elish-common.dtsi} | 4 ----
> 
> This breaks the build.
Thanks for spotting it. I will fix it in v2.
> 
> Best regards,
> Krzysztof
> 
