Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1736273CAEA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 14:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjFXMbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 08:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjFXMbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 08:31:05 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7958E5D;
        Sat, 24 Jun 2023 05:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1687609858;
        bh=mVIJR4nMBjtez2qGjfCXvDgWZNOR+zXfVhJPIUl/Iv4=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=VVs3b+cKfTVsbQ04tkLwm1dwlaFoywd9QVlDOQ1Mla3JQSx0THZQB/I2qZV/kngZg
         rxfUENf2roXtZmUFsEr2WrVwlyHCnHN3m7LJLwq12W/3Q8K2xLawib0u9p3y81jMGz
         zPyD5W3t7sI49wOt6Bn86Soufm1TNXZ+2yrqwMso=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9E95E12862C2;
        Sat, 24 Jun 2023 08:30:58 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id JMB_OKpXtfZI; Sat, 24 Jun 2023 08:30:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1687609858;
        bh=mVIJR4nMBjtez2qGjfCXvDgWZNOR+zXfVhJPIUl/Iv4=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=VVs3b+cKfTVsbQ04tkLwm1dwlaFoywd9QVlDOQ1Mla3JQSx0THZQB/I2qZV/kngZg
         rxfUENf2roXtZmUFsEr2WrVwlyHCnHN3m7LJLwq12W/3Q8K2xLawib0u9p3y81jMGz
         zPyD5W3t7sI49wOt6Bn86Soufm1TNXZ+2yrqwMso=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id F39711286268;
        Sat, 24 Jun 2023 08:30:56 -0400 (EDT)
Message-ID: <38e69be8524c85062e627f77ed7ad766905e60a3.camel@HansenPartnership.com>
Subject: Re: [PATCH 5/5] scsi: dt-bindings: ufs: qcom: Fix warning for
 sdm845 by adding reg-names
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sat, 24 Jun 2023 08:30:54 -0400
In-Reply-To: <CTK1AI4TVYRZ.F77OZB62YYC0@otso>
References: <20230623113009.2512206-1-abel.vesa@linaro.org>
         <20230623113009.2512206-6-abel.vesa@linaro.org>
         <cd84b8c6-fac7-ecef-26be-792a1b04a102@linaro.org>
         <CTK1AI4TVYRZ.F77OZB62YYC0@otso>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-06-23 at 14:38 +0200, Luca Weiss wrote:
> With my private mailbox I just have a different folder for patches
> that have been sent which I archive once they're applied, but with
> work GMail I don't see how I can easily replicate this since it's
> also not grouping threads properly.

I have something similar, but instead of multiple folders, I use imap
labels to achieve the same thing (and then evolution search folders to
sort out the labels).  I believe GMail has some primitive labelling
system that actually works (unlike exchange), so you might be able to
get a scheme like that to work.

For my mobile phone, which doesn't have the sophisticated search
folders evolution does, I use dovecot virtual folders to achieve the
same effect.  I'm afraid I don't think GMail has any equivalent of
this.

James

