Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA77714CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjE2PH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjE2PHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:07:53 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9921C4;
        Mon, 29 May 2023 08:07:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685372870; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=e1WW4XsTpdAQP1Hfrtfz1Z4NDYLxzleVB5bBz122yxf/qIAiFYEbCLGmzgiIneCerx
    PWMZkLLTizyuhsSx9IZezT1Dm3aRfK8bCAABUNLvtkzdHqVMDFxGW0/sqK5afs0bU8iC
    onnTb3rZg09EAoOgaZtAfl0JjrWNXMnKu5VsM/meX3nd1HQhhVYvLCiGEwgUc44IClR4
    UA6FFV6MAMcnmeF8dnw+En4e/RwdCqZ54U5mUYgbrBWalLz91hoqi27lpR1SeWWnFShB
    u2XsusvqCp1bmYklDCsUHRbeYipDqucJURAO6akSdI/CdaYG6IX917ZEldyYoaQGdjV9
    YvXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685372870;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=tud/erIICHaLnTpVAwdYN5wz1o/STh6geYXi8mR0I9w=;
    b=X4OTIKlvesWcmLh0R5zLI4rk7tt3Q/j04RiSEd/2Ma0CkDzUaEzoZRD23+v4yLI21k
    OhjAdLpBaGmYF4bw5UaMh9xEOwYR1Oo2xy6Se5FeBstotjPIH431BWPpDpB7hrE8Ul4G
    QKHXUAxc/rSjYKsFbJtOAQGd3kMWuUU72RxMK6QrGozeQ8a6rmcQ5WCQm3LZaHYQiLBW
    dq9c1/PWl0kkHUGbOlUfGj+Hwe2AkSoYcckWdbY1o558JFG4AtC0rWf8Wu+jIrCWhHuI
    Z89tFTNVxC9woUOK5jz9VRhQunNkbFZ7goJORjMR+tXQKMOdzE5thNdKUABE0UN5lC/u
    L87g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685372870;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=tud/erIICHaLnTpVAwdYN5wz1o/STh6geYXi8mR0I9w=;
    b=bPD7CpX+5oZQrWV1HPevPZZvITF4o64dTJRPmNbdzAlfLfud4pF/JqnNllqj10X3KE
    z+No2igJHl5gOEnzIZuZ62YZVo/4Aj1LlopjDCu/Qa5dzoP/9Qm9O92b53rPtvBg7Z5r
    IAeros26v7EHfXMI+QLXhbE+YOTY929D2LbyjDqo04k1hw2RibEiJ5cbnelhamDNeadZ
    Kixpx7kdIZ87KCBNu0OiOQZHmHjvr+iOV7ml5Q7CkdMCXmTS3Hlb3pPW75p4cwqDZNcp
    7Ou27qPbNYHgweNQm4pgYf5/bdKRZvUcyGT6A73YivZB2lIFSXmzoaEIUZ1fr7Yp3OoN
    BpNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685372870;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=tud/erIICHaLnTpVAwdYN5wz1o/STh6geYXi8mR0I9w=;
    b=3tZJRLqfg9JpN7/pzY6QtgcNiaoZ6foFeb1Y4DOaMShKjCbNXW283cjkTjyUPWHYWu
    cZbqiDgiDBzBf+YDG4Dg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8pqP1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4TF7ofFm
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 29 May 2023 17:07:50 +0200 (CEST)
Date:   Mon, 29 May 2023 17:07:49 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64: dts: qcom: pm8916: Rename &wcd_codec ->
 &pm8916_codec
Message-ID: <ZHS_xTvBEzngiyrB@gerhold.net>
References: <20230525-msm8916-labels-v1-0-bec0f5fb46fb@gerhold.net>
 <20230525-msm8916-labels-v1-5-bec0f5fb46fb@gerhold.net>
 <e1f5e719-5b38-a258-2778-5dfe9a7dcf5e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1f5e719-5b38-a258-2778-5dfe9a7dcf5e@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 02:47:30PM +0100, Bryan O'Donoghue wrote:
> On 29/05/2023 13:47, Stephan Gerhold wrote:
> > All definitions in pm8916.dtsi use the &pm8916_ label suffix, only the
> 
> That's a prefix_ not a _suffix
> 

Right, my bad :)

> > codec uses the &wcd_codec label. &wcd_codec is confusing because the
> > codec on MSM8916 is split into a "wcd-digital" and "wcd-analog" part
> > and both could be described with &wcd_codec.
> > 
> > Let's just name it &pm8916_codec so it's consistent with all other PMIC
> > device nodes.
> 
> I'm not sure that's really consistent throught the dts/yaml TBH but, I do
> think the pm8196 name is more meaningful and clear.
> 
> What is wcd supposed to stand for anyway ? Its probably obvious but I prefer
> pm8916_code since that *is* obvious.
> 

I think WCD is the typical prefix Qualcomm uses for its dedicated audio
codec chips. There is no WCD* chip on MSM8916/PM8916 because the codec
was split and integrated partly into the SoC and partly into the PMIC.
I guess the "wcd" name just survived for historical reasons.

Looking at "WCD9335 Audio Codec - Device Specification - LM80-P2751-29
Rev. A - Table 1-2 Terms and acronyms" apparently

  WCD = WSP codec device
  WSP = Wafer-scale package
  WSA = WSP smart amplifier

> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> 
> Seems like a valid change but, consider amending your commit log.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 

Perhaps Bjorn can fix "prefix" -> "suffix" in the commit message when
applying, doesn't seem worth resending for that alone. (Will fix it of
course in case I send a v2 for other reasons!)

Thanks,
Stephan
