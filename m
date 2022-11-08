Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1F0621904
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbiKHQEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbiKHQEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:04:38 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB9F554DD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 08:04:37 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so18310640pji.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 08:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4L0lpxFgO08elzxEtFZTCq5Rc3ge2xMVqe4z2m5l5wc=;
        b=A0oz87VXTZAnhZ0m8CQYGaqCJt7I/iJ8VMWO7Ia8ixaAVV/jaPgBA8zDBTUNOjQnor
         3uaqGwKOL+9R7cp5RIWfK8Afcv5w4MyShRoWwpc0ne358Y9HQ1qNykYG+u9bgM4Y7y2C
         bfGtaHk+YPidVzxOFydB83w26Enpi9jWnWJFiucubh1PtHx8DeURE3jfDqwGPkKr4sn3
         +HscKsItoi4gn5ym3DhSG1E57kcMGHsRLjN79ss3cj9omuT/hNhnbXn9JJen57WUW/OG
         2w6pTXB/65shmdOKkoEI++p+Y6FX9L89/ds+2xZS+31CJY9FEMxLDaTJ6PANfyTdJUQn
         aOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4L0lpxFgO08elzxEtFZTCq5Rc3ge2xMVqe4z2m5l5wc=;
        b=dkYzw96E0ecJykTPjTW/nDSyrSnzxYN3bZ7YS5gUYnrhifpKY59U1mVOn8ZQ8HeSVl
         tQF1WDWuanQ518oiEOddSxCE0h+t+8MrkAmfCTP4ggl71JVOzx0+20GsG7q0LKCb6q+H
         0gA9o4C3RtMKZSlp+wDUl0eZ0otN5FLr+YctPnsP0Q/6gazCjNKvK3WRDzhkZ3pIgFwN
         ixuzGiNlwSOJyQ+FmFKDaLGI7zMaINTeSkDx2GgS9kkgPkvqvmetVfHB7E9wM1IBTzWb
         +xr7qX3UvYV9/ZZzkWS/LZ3fsfx8GnvwdavxVGCxooHnYKSilbpixIri0mJPU4RdDWd3
         Tp5g==
X-Gm-Message-State: ACrzQf3DX5BjrTDXwLJQ6xxj13oIZ0NwRx4wiTjGglZDVTKhSd6Aadi5
        FZSa26L8eMEdRgO8wHinJyS0SiQMGZonEmaRHpX91g==
X-Google-Smtp-Source: AMsMyM7TbT/aYwtVR4cqz4woE5o/71SJRXngQtG6YCrAh1dB18sTimWfSWV0k2qjNcC6qDEuFLBx2IAPwVGpiyKgIDA=
X-Received: by 2002:a17:902:8c92:b0:178:29d4:600f with SMTP id
 t18-20020a1709028c9200b0017829d4600fmr57171112plo.40.1667923417870; Tue, 08
 Nov 2022 08:03:37 -0800 (PST)
MIME-Version: 1.0
References: <20221108082533.21384-1-hayashi.kunihiko@socionext.com> <20221108082533.21384-5-hayashi.kunihiko@socionext.com>
In-Reply-To: <20221108082533.21384-5-hayashi.kunihiko@socionext.com>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Tue, 8 Nov 2022 10:03:27 -0600
Message-ID: <CAJe_ZhfMq1ET+TonauySxfCUv2n=xrsEf9T4o9zePwS5feeGMg@mail.gmail.com>
Subject: Re: [PATCH 4/4] mmc: f-sdh30: Add compatible string for Socionext F_SDH30_E51
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2022 at 02:25, Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
....
> @@ -228,6 +229,7 @@ static int sdhci_f_sdh30_remove(struct platform_device *pdev)
>  #ifdef CONFIG_OF
>  static const struct of_device_id f_sdh30_dt_ids[] = {
>         { .compatible = "fujitsu,mb86s70-sdhci-3.0" },
> +       { .compatible = "socionext,f-sdh30-e51-mmc" },
>
This also needs to be specified in the dt bindings, not just in the driver.
And if this patchset is for the "e51-mmc" type controller, introduce
the compatible first and apply the changes for that controller.


> @@ -258,4 +260,5 @@ module_platform_driver(sdhci_f_sdh30_driver);
>  MODULE_DESCRIPTION("F_SDH30 SD Card Controller driver");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("FUJITSU SEMICONDUCTOR LTD.");
> +MODULE_AUTHOR("Socionext Inc.");
>
Socionext now is what Fujitsu was when this code was written, so this
addition seems ok.
So may be add it as
    MODULE_AUTHOR("FUJITSU SEMICONDUCTOR LTD., SOCIONEXT INC.");

cheers.
