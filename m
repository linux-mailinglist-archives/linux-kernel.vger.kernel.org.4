Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CD35B412A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiIIVAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIIVAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:00:13 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10D34A80B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:00:11 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id l40-20020a4a94eb000000b00472717928b5so467510ooi.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 14:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=M8jtTpYkUx+qSYcYHZXqXNBn3kSBt02rTRB42krXs0U=;
        b=DGxSDy6/vnJ7Vxfcnjv/652ZQXFAWTJedpkyZOzrTsy4EbOpewz+869pECqTS7qHE0
         qGLroHGf69JxCQIONFiIXgHilvV4kT7Qf/YdIQwyP+5/DJac7n1s0m5Qtw6iW3h9JwCC
         vxTNvGXsdhr1IZFM+fwybuc5nU2NT1BmiWFb2oqpbSkg0sS6TxH5jvqi59XxHaK7cil3
         V7svw1Z5nTnwoK6SJUc8KUepZtMMLSBU4FdK7EstV8gE8VcNv2YelwbZGPCCAK9UygGe
         gyhtkLiFsUaHOsOmELyE6Wsdqvx9ud+UThupRtDWXiUkXAttH4N3SAoXHW5Qtmh+Oe7o
         niqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=M8jtTpYkUx+qSYcYHZXqXNBn3kSBt02rTRB42krXs0U=;
        b=33A3HpGChhgG7+PobolfPJOj53mVhHKsMo1kBB13A9UsIMAPOvEWVE/Yaq9PC5pV/a
         YCsoS+obMLqXzOv6PsmTH/KpgTSQ9O8I//276BijwAEiApKK5YIeN6FI3RLE2ZLV8BHF
         DXyWLwVJoRO+aUuYn8vpImPo8fKn02CcSt4S3CdXnPvdSFQiX5DYMU2HDUeK7lZXLYH2
         P6SGN1LYLoJSNKhTqbjcwofNkp0gghPFmniMspexi0mOwshw2MiTub7ZnDB1JNWLHyXr
         oIc1blZqOw8ZONILL+2bqaEw2oc+U5jtn9/Y1qJ7vxHluxfsQkhdbkJzA+PjWwbg/veH
         Q+fQ==
X-Gm-Message-State: ACgBeo1qoHQcGVmNiK69UTxZxy/op+rtFMRX8NpdqMCR5PD1GbbY3XGF
        JKXH6oe00zpMGxWAHw9+agItnfsHrH0NPz0Ef4Q=
X-Google-Smtp-Source: AA6agR7AsYoshYD5atldZXlBSSJ41Zk/4yGDqCjPj1t9rAIRz3Qx2hwr1VJnV3pmI9mX62MVcKkVNhQGZ/UjSJ6CBiw=
X-Received: by 2002:a4a:a78a:0:b0:472:a078:98d6 with SMTP id
 l10-20020a4aa78a000000b00472a07898d6mr2334077oom.97.1662757211174; Fri, 09
 Sep 2022 14:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220907041058.935-1-yuanjilin@cdjrlc.com>
In-Reply-To: <20220907041058.935-1-yuanjilin@cdjrlc.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 9 Sep 2022 17:00:00 -0400
Message-ID: <CADnq5_N3uLVZOCMbrq6yq_GdyFFUo1CVUXckHYAxdfHRecBx3w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix repeated words in comments
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, Charlene.Liu@amd.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Wed, Sep 7, 2022 at 12:11 AM Jilin Yuan <yuanjilin@cdjrlc.com> wrote:
>
> Delete the redundant word 'in'.
>
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_audio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
> index bdb6bac8dd97..c94a966c6612 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
> @@ -300,7 +300,7 @@ static void set_high_bit_rate_capable(
>         AZ_REG_WRITE(AZALIA_F0_CODEC_PIN_CONTROL_RESPONSE_HBR, value);
>  }
>
> -/* set video latency in in ms/2+1 */
> +/* set video latency in ms/2+1 */
>  static void set_video_latency(
>         struct audio *audio,
>         int latency_in_ms)
> --
> 2.36.1
>
