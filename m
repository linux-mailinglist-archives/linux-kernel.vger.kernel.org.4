Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B4963F514
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiLAQSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiLAQSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:18:05 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442E329804;
        Thu,  1 Dec 2022 08:17:58 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so5716562pjp.1;
        Thu, 01 Dec 2022 08:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfYDYtDdWSpf1BGYU9m6venf9VFVD+ygFyov+HV7Yms=;
        b=cw36wKEXB3mUS1v978XCAC5BErch3wt26EUPwdmLPXj1m8t29fZNTgvr7oPFxoiyD0
         OFW3LbV2bpmtoHr2GslOsX7QLs7OxWkp10Y+HVkrM1YBvCEYeB6CpdgQmQtchqtpCZIy
         dP7mF4meMDd+XzCOeWZHLdQvp7OjZJY+jk+on65lACTP3pO5uLycazQpPumN9z1Xg3jZ
         mOFaqPbrPEMllLZrnVXRoadlRk4FYUMiKibVTFOZRqtjoMgygN928U0Z160q+70xd2Rt
         1o7L6i6qIX0TIEI7K4r8wc+W31ZGHc+c/vkb1eQCbDCcLJSrDSVswi+p1zmthMqgMxYw
         UjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BfYDYtDdWSpf1BGYU9m6venf9VFVD+ygFyov+HV7Yms=;
        b=cjDnqAzPst6BZg10hDufj+y7eqp7Lhy+noMiZebU/Mwdq0K+qux/p11Hy3xFMKd7Ks
         or2vc0XDqkREyabDW97bNfiAxqS0dK1FizUVaR3rYGgrDkbjBold7KQfNF5A3YspSFAy
         JUEynac9bQ4ac6Bt0j9WLKdY4LCn1bPtc2MN9VQsBoAYjsvtKSHbXjP0h8KJvEdEO71p
         QJhr5Q+ILcIFiHGq4QP6Ijxd760tJcm5ba0LT+SGtq2afUWlGqS/Y25BHD/C3Kf94ZjN
         UsPwqXBIU+N8zQy+Xiyt0XtyVI16P7+KBbnK33poX4Ia92mgf/KcAxZ8qO13WmEQND8e
         VMCg==
X-Gm-Message-State: ANoB5pnPuo4t48CBfs/vfO5vXkcpHNIg0CMHQbeEAL7I4poraHqh48Pf
        jdz3adAHjL7bP6C01rES7T49y8QgiKM=
X-Google-Smtp-Source: AA0mqf4/5D6L8Y5ZjG68qTNyUWBPsQBG1ZoClZZ/oqliodHgdPhFZcqo7Rs86REz+mv/oSRaMlsm0g==
X-Received: by 2002:a17:902:d4c8:b0:186:9d71:228c with SMTP id o8-20020a170902d4c800b001869d71228cmr50156573plg.109.1669911477675;
        Thu, 01 Dec 2022 08:17:57 -0800 (PST)
Received: from localhost ([2406:7400:61:64d5:7d23:c512:7205:1e52])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090276ca00b001894881842dsm3837104plt.151.2022.12.01.08.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 08:17:56 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 01 Dec 2022 21:47:49 +0530
Message-Id: <COQM7MGKFRUI.25DOQ1AAQLLY7@skynet-linux>
Cc:     <linux-arm-msm@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <phone-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 4/9] dt-bindings: remoteproc: qcom: wcnss: Convert to
 YAML
From:   "Sireesh Kodali" <sireeshkodali1@gmail.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <linux-remoteproc@vger.kernel.org>
X-Mailer: aerc 0.13.0
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
 <20220511161602.117772-5-sireeshkodali1@gmail.com>
 <e8a86b3e-7a2f-3434-52d8-6a827b720f92@linaro.org>
In-Reply-To: <e8a86b3e-7a2f-3434-52d8-6a827b720f92@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Dec 1, 2022 at 6:52 PM IST, Krzysztof Kozlowski wrote:
> On 11/05/2022 18:15, Sireesh Kodali wrote:
> > Convert the dt-bindings from txt to YAML. This is in preparation for
> > including the relevant bindings for the MSM8953 platform's wcnss pil.
> >=20
> > Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> > ---
> >  .../bindings/remoteproc/qcom,wcnss-pil.txt    | 177 --------------
> >  .../bindings/remoteproc/qcom,wcnss-pil.yaml   | 228 ++++++++++++++++++
> >  2 files changed, 228 insertions(+), 177 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,w=
cnss-pil.txt
> >  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,w=
cnss-pil.yaml
> >=20
>
> Half year passed, so I wonder if these series are abandoned or shall we
> expect v2?
>

This series was split into sub-series to make upstreaming easier. Links
to the sub-series:
WCNSS: https://lkml.org/lkml/2022/9/30/1502
ADSP: https://lkml.org/lkml/2022/10/13/5

Regards,
Sireesh
> Best regards,
> Krzysztof

