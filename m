Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0B563E6AF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 01:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiLAAqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 19:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiLAAqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 19:46:52 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3324226105;
        Wed, 30 Nov 2022 16:46:51 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id s8so89639lfc.8;
        Wed, 30 Nov 2022 16:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pqmTUQSzfvHEUN+F2iBAqrzmDtyHBEj68ag1QEGOo5k=;
        b=f1S0Iaezu+w258iDOTh+9ghB5uI1fUdHmbT0jBMTEKAkXlphFoBzKWbQXQLKZI1oUw
         DxY8LmS9v4Ggm8YYLhyrrmC16pnsjEj0cHPba0kREouJJ1yCjB5OUB+Jvvlue3+szoya
         rx/6aI7Y469SUKF4AC9jxPy7OsscMfKX800USz+OGbiuzWp+nSN+SuT9UOxb3VLIo1K9
         dR5ih2VTix7n7EDJ6VeqOVZ6+b5LW+KGgLgbnqieknFHz4nJ2bsnqoFLY1u4INXJpQx4
         pN3Ez2jBRAeVKqwRFHmGUtnoNWJhH/EiUon7UW+vUayDD9Yy66FEC9WdA9G3iqjBaggj
         Q2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pqmTUQSzfvHEUN+F2iBAqrzmDtyHBEj68ag1QEGOo5k=;
        b=pVpWK0bDFKFgTMHGagAKsCKkn1OIcK8pW8cdy6f7HwuWK7V1kB4wNK4g/35ki30a8q
         H7QHsYUuYmQ51Nk4t12YOU5KXFSdT3ABl9Mh+SugIyK9BCp+hRMCbF3k9MATIvB6TW6z
         kXcciBnKHwKr+ZU3qgmix+rR6MWaegmVDZZqeYNcvg234n66tTBm9sFbuW6AyCt+BkFc
         OyfmeHzFAlKSXLagVjolPirO7BeGZHp7QDhAz2fI8DsBJDNGqouw65eZRtI8GxBdheKu
         91hhHhMA8+gZPqg2RE5QbS0Sd8MENEsOt+8tCgR5/lTb13wr+0G8BqHxgerNbtA4lcJD
         Y2Lw==
X-Gm-Message-State: ANoB5pnLS7FYCsguAcPJ/jGi8so8gOTHRn6emnP44q+054BbHPGVyL5a
        sAPgF7f1uiYXNn9ZE7RkvFeOJcumGJrdlmvRPA==
X-Google-Smtp-Source: AA0mqf4vHvRmkLVnJATGVXP8yIbONkm4WrfoF0VaAmg6bfLPGtJ3Gta4zmzl/qowugYsMaLlUzOtPSoS8uF+jRo/WVA=
X-Received: by 2002:a19:6a18:0:b0:48b:1973:e3bf with SMTP id
 u24-20020a196a18000000b0048b1973e3bfmr19037636lfu.328.1669855609404; Wed, 30
 Nov 2022 16:46:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1669850856.git.quic_asutoshd@quicinc.com> <f4bb4850076c9a953eaaa9e76dc3b2fa37f0505e.1669850856.git.quic_asutoshd@quicinc.com>
In-Reply-To: <f4bb4850076c9a953eaaa9e76dc3b2fa37f0505e.1669850856.git.quic_asutoshd@quicinc.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Thu, 1 Dec 2022 08:46:37 +0800
Message-ID: <CAGaU9a-T3YFQ6XJAee_zU9idN=cx=KLaONtMppAabv6oMPxwMw@mail.gmail.com>
Subject: Re: [PATCH v9 02/16] ufs: core: Probe for ext_iid support
To:     Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     quic_cang@quicinc.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        eddie.huang@mediatek.com, daejun7.park@samsung.com,
        bvanassche@acm.org, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 8:05 AM Asutosh Das <quic_asutoshd@quicinc.com> wrote:
>
> Task Tag is limited to 8 bits and this restricts the number
> of active IOs to 255.
> In Multi-circular queue mode, this may not be enough.
> The specification provides EXT_IID which can be used to increase
> the number of IOs if the UFS device and UFSHC support it.
> This patch adds support to probe for ext_iid support in
> ufs device and UFSHC.
>
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
