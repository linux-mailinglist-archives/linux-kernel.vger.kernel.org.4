Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F083F5FCA2E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiJLSCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJLSCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:02:02 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15096DD898;
        Wed, 12 Oct 2022 11:02:01 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q1so7829392pgl.11;
        Wed, 12 Oct 2022 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mI6JTDhKVYSrCGCD4V56C9X6Kiak+3dUkc3QnuibHPU=;
        b=ZwTl6AAaQ0Ws45vSBrLIcUrnyeGPkzph09dsda8I/3iok8sidXoeHPpBSYWXOhWO4I
         VotyRNrTD2SYFyLa0rgP3w9dLcgU0io4629+19FHN7tg5P7vrE9tTi871hDFV81cYjgf
         s05P6xeO/0de/53iAG8UuId+EXcpeOBccSvpUxeEcWXz9cyEyrKfHnYSvuhWjccb6/CE
         sQNFkSa7PZFUOTCbx/fQ+02VgEkRTs0qibiKXdmr7plpmDS/81QioTTfVhHBbYG8fTqo
         CQoct7DhqlQpGvbd6vSyxz/dbVVl7CyWJ2771hpPjKopD5so1Nq8b4vzopepLQvUUL+V
         tXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mI6JTDhKVYSrCGCD4V56C9X6Kiak+3dUkc3QnuibHPU=;
        b=bYEYMkdXdGL8vg+I3STyGeb1izw5IYtr7/ObPH9POETAXf98dFkfnJZoI6ylm71pAR
         LlVci1EYwZSCplV+AdgLd2PC0kPOS/aVWYyZOrnIAB4OFd0OHUUasuJo3p46XQQgNTE/
         rh1Kq2e7uxjjo2JT3Qe+QgNMT5MjjmXegWzSQz34y8m455E+b19lRMODg4ALuJQUk35Y
         QGmoAL7CdFHMVXmPgIcpLzQlR/vWAfJu64pBNxkgMqyzkCx8DgLUl9I3l63Y3uCeBnXV
         GlXBoq8v9RH/w870x/+IWQJz5v7jjdJ5aaAhuV64hl0AjDApHmzOZuXSYvXMohKpQgw0
         9G6A==
X-Gm-Message-State: ACrzQf1RVHuQA/eEm0mIXlVeHbBVeh11x+3V7ac/+/X+C1BCu1++CN8M
        +B07ZkVvs9KNKFWIPL80+aiTvSS4kfKKYA==
X-Google-Smtp-Source: AMsMyM6wGKajSAd4wPGHhoHm+LRw505WIZj871/gi+wZTScVudBPvwvqo9aSHUegpMeeYFn/afRAgg==
X-Received: by 2002:a63:1c47:0:b0:44c:2476:12ff with SMTP id c7-20020a631c47000000b0044c247612ffmr27537426pgm.50.1665597720308;
        Wed, 12 Oct 2022 11:02:00 -0700 (PDT)
Received: from localhost ([2406:7400:61:b6fa:b70b:65a4:a699:40c8])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b0016c50179b1esm10777750pln.152.2022.10.12.11.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 11:01:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 12 Oct 2022 23:31:51 +0530
Message-Id: <CNK541A4RD4B.31EY633R2WS9O@skynet-linux>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <linux-kernel@vger.kernel.org>
Cc:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.baryshkov@linaro.org>, "Andy Gross" <agross@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v3 1/2] remoteproc: qcom: pas: Add MSM8953 ADSP PIL
 support
From:   "Sireesh Kodali" <sireeshkodali1@gmail.com>
X-Mailer: aerc 0.12.0
References: <20221008174658.336470-1-sireeshkodali1@gmail.com>
 <20221008174658.336470-2-sireeshkodali1@gmail.com>
 <56e8fc84-aad0-b153-e415-8c1bd1647c2b@linaro.org>
In-Reply-To: <56e8fc84-aad0-b153-e415-8c1bd1647c2b@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Oct 10, 2022 at 4:22 PM IST, Krzysztof Kozlowski wrote:
> On 08/10/2022 13:46, Sireesh Kodali wrote:
> > Add support for the Audio DSP PIL found on the Qualcomm MSM8953
> > platform. The same configuration is used on all SoCs based on the
> > MSM8953 platform (SDM450, SDA450, SDM625, SDM632, APQ8053).
> >=20
> > Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> > ---
> >  drivers/remoteproc/qcom_q6v5_pas.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qc=
om_q6v5_pas.c
> > index 6afd0941e552..70b3a37c4814 100644
> > --- a/drivers/remoteproc/qcom_q6v5_pas.c
> > +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> > @@ -950,6 +950,7 @@ static const struct of_device_id adsp_of_match[] =
=3D {
> >  	{ .compatible =3D "qcom,msm8226-adsp-pil", .data =3D &adsp_resource_i=
nit},
> >  	{ .compatible =3D "qcom,msm8974-adsp-pil", .data =3D &adsp_resource_i=
nit},
> >  	{ .compatible =3D "qcom,msm8996-adsp-pil", .data =3D &msm8996_adsp_re=
source},
> > +	{ .compatible =3D "qcom,msm8953-adsp-pil", .data =3D &msm8996_adsp_re=
source},
>
> This one also in alphanumeric order, by compatible.

Will be fixed in the next iteration

Regards,
Sireesh Kodali
>
>
> Best regards,
> Krzysztof

