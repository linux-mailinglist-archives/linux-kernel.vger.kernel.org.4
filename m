Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F02D5F0393
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 06:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiI3E2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 00:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiI3E2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 00:28:46 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA983F1D4;
        Thu, 29 Sep 2022 21:28:45 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so7850991pjs.4;
        Thu, 29 Sep 2022 21:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date;
        bh=cifIfLO4EdVKW63K9YetCP67akD4Fy7QshBaWPMRel4=;
        b=Q+iY2xKACsdQFn4a5l6oBgeEUjWwyLXucCgEhoXbQWxkLGMxt1hYZutX0VVoixwJXf
         TwVRDhDqYM+MFMgV2HktgLpn5Rv8dW0FgYNZyMpLX9XgHjAzeZgpLmH+zFa0WZBEafx7
         FvVrKVCaDz25E4PDtcTdJ5UhDJD6g1mvIiDD5gKDvd47/os30FQaPAKwWOKLL3phiN/S
         lBHENHFr4lN7DBB4YzrDH6XMwOf55G8SN8f91OC26mb2KhXcWmzyI/GWuyxUMMu8GUIG
         2qHxOe6VqEEHxvbaHy/mm5g4b4bUC/VpXiQdwb37Zj3M+T5TP55nz/xs0xI6Dqbs/na9
         /hUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date;
        bh=cifIfLO4EdVKW63K9YetCP67akD4Fy7QshBaWPMRel4=;
        b=6QkEGkhrtGYxGEQgBL5nmsMobiotDtCjGOwhOb3umyBvLJij3aaqs8OTWqMgBLDMOW
         o276cc1YroEjzmyfwEShUJzAREWH3Q7Dspm5HZlcDWhKaJ1b3UhXHbw9aF6moCx8ZOoY
         ms6A2z64eJO1IUleATfY2DWIUwfhax43ug5zyImQyG6xuqZ1DedcxvXzCToq+LWxolgc
         ry+QoXCsMZ77nhlDho3pOyt9zvEpY4fiZDKDmV61hsWW15CLYO6JehWWyzi1UQNBdnCI
         bI6vmzPedgCrufQneit8jK34n5HbV6L+yq++F7wj5RA8ey10yIRvU3rILtDQ91QvRwZ0
         I0GA==
X-Gm-Message-State: ACrzQf21jhFHvmQMMWKw3awQ5dWz9gHFN/EhwWEgMxhx4cfkBpePoQCD
        WlTcHicFXU7CwxZf24snnqlal+uoBKkeAobD
X-Google-Smtp-Source: AMsMyM6C/PAa+EOJnltX2UfPGfD8gHe7jpYUGYj5I580lKg8IdAaEo5Ji4kKZ6NtpWkAoXLN3oYesA==
X-Received: by 2002:a17:90b:38c6:b0:203:3dfd:6fcc with SMTP id nn6-20020a17090b38c600b002033dfd6fccmr7330393pjb.96.1664512124536;
        Thu, 29 Sep 2022 21:28:44 -0700 (PDT)
Received: from localhost ([104.28.220.174])
        by smtp.gmail.com with ESMTPSA id i16-20020aa796f0000000b0053ab9c18d3csm595042pfq.14.2022.09.29.21.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 21:28:43 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 30 Sep 2022 09:58:36 +0530
Message-Id: <CN9GAU5VE065.3P5LN5Y0FZOKE@skynet-linux>
Cc:     <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <linux-kernel@vger.kernel.org>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        "Vladimir Lypak" <vladimir.lypak@gmail.com>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v5 1/5] remoteproc: qcom: qcom_wcnss: Add support for
 pronto-v3
From:   "Sireesh Kodali" <sireeshkodali1@gmail.com>
To:     "Stephan Gerhold" <stephan@gerhold.net>
X-Mailer: aerc 0.12.0
References: <20220929050209.1464526-1-sireeshkodali1@gmail.com>
 <20220929050209.1464526-2-sireeshkodali1@gmail.com>
 <YzVn3Q81bCo4l/aQ@gerhold.net>
In-Reply-To: <YzVn3Q81bCo4l/aQ@gerhold.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Sep 29, 2022 at 3:09 PM IST, Stephan Gerhold wrote:
> On Thu, Sep 29, 2022 at 10:32:05AM +0530, Sireesh Kodali wrote:
> > From: Vladimir Lypak <vladimir.lypak@gmail.com>
> >=20
> > Pronto-v3 is similar to pronto-v2. It requires two power domains, and i=
t
> > requires the xo clock. It is used on the MSM8953 platform.
> >=20
> > Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> > Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> > ---
> >  drivers/remoteproc/qcom_wcnss.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >=20
> > diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_=
wcnss.c
> > index 68f37296b151..ff18bfae5eb6 100644
> > --- a/drivers/remoteproc/qcom_wcnss.c
> > +++ b/drivers/remoteproc/qcom_wcnss.c
> > @@ -141,6 +141,18 @@ static const struct wcnss_data pronto_v2_data =3D =
{
> >  	.num_vregs =3D 1,
> >  };
> > =20
> > +static const struct wcnss_data pronto_v3_data =3D {
> > +	.pmu_offset =3D 0x1004,
> > +	.spare_offset =3D 0x1088,
> > +
> > +	.pd_names =3D { "mx", "cx" },
> > +	.vregs =3D (struct wcnss_vreg_info[]) {
> > +		{ "vddpx", 1800000, 1800000, 0 },
> > +	},
> > +	.num_pd_vregs =3D 2,
>
> Can you try dropping this line? num_pd_vregs =3D 2 means:
> "If power domains are specified in the device tree, skip the first two
>  entries in 'vregs'." For pronto-v1/v2 it would skip the "vddmx" and
> "vddcx" entry, since those are already covered by the power domains.
>
> However, since pronto-v3 should always have power domains in DT and
> "vregs" has just a single entry this means that it would always access
> the array out of bounds at runtime and request some garbage regulator.
> I'm confused why this does not crash more spectacularly...

Indeed it should have crashed, thanks for catching this. Will be fixed
in v6
>
> Thanks,
> Stephan
>
> > +	.num_vregs =3D 1,
> > +};
> > +
> >  static int wcnss_load(struct rproc *rproc, const struct firmware *fw)
> >  {
> >  	struct qcom_wcnss *wcnss =3D (struct qcom_wcnss *)rproc->priv;
> > @@ -675,6 +687,7 @@ static const struct of_device_id wcnss_of_match[] =
=3D {
> >  	{ .compatible =3D "qcom,riva-pil", &riva_data },
> >  	{ .compatible =3D "qcom,pronto-v1-pil", &pronto_v1_data },
> >  	{ .compatible =3D "qcom,pronto-v2-pil", &pronto_v2_data },
> > +	{ .compatible =3D "qcom,pronto-v3-pil", &pronto_v3_data },
> >  	{ },
> >  };
> >  MODULE_DEVICE_TABLE(of, wcnss_of_match);
> > --=20
> > 2.37.3
> >=20

