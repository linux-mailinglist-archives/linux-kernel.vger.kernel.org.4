Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C33E5EAC1B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbiIZQLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbiIZQLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:11:12 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4725727C;
        Mon, 26 Sep 2022 07:58:38 -0700 (PDT)
Received: from g550jk.localnet (2a02-8388-6582-fe80-0000-0000-0000-0006.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::6])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 3E228C78D3;
        Mon, 26 Sep 2022 14:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1664204279; bh=+gRELho+elraLKMrRC6MdHj9PsEtvYJMfn8C8YeYSdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aw78OVKzM/k2C43ruye/FvslE7NxrZLiGFo1QidJFG6q5QqI6Kfa5djYnsHldlxwm
         wWm5TTClK6NeRvuXlZFpM8ii4u+/dAMT0uRrfActoJNI+DnjfqJj3hZa1q435lKmF+
         hktet3hJOsDxVXyjNJZe0PTE/yWfLZozp2OHS0Og=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org, neil.armstrong@linaro.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom-pma8084: fix vadc channel node names
Date:   Mon, 26 Sep 2022 16:57:58 +0200
Message-ID: <2647127.mvXUDI8C0e@g550jk>
In-Reply-To: <98960452-9f48-7b4d-9aa6-55c0002ad1b4@linaro.org>
References: <20220925202143.123208-1-luca@z3ntu.xyz> <98960452-9f48-7b4d-9aa6-55c0002ad1b4@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Montag, 26. September 2022 10:27:54 CEST Neil Armstrong wrote:
> On 25/09/2022 22:21, Luca Weiss wrote:
> > Node names for the channel are supposed to be adc-chan@REG.
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> > 
> >   arch/arm/boot/dts/qcom-pma8084.dtsi | 17 +++++++++++------
> >   1 file changed, 11 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-pma8084.dtsi
> > b/arch/arm/boot/dts/qcom-pma8084.dtsi index e77602e9f95c..7ad573c7b4ac
> > 100644
> > --- a/arch/arm/boot/dts/qcom-pma8084.dtsi
> > +++ b/arch/arm/boot/dts/qcom-pma8084.dtsi
> > @@ -64,22 +64,27 @@ pma8084_vadc: adc@3100 {
> > 
> >   			#size-cells = <0>;
> >   			#io-channel-cells = <1>;
> > 
> > -			die_temp {
> > +			adc-chan@8 {
> > 
> >   				reg = <VADC_DIE_TEMP>;
> >   			
> >   			};
> > 
> > -			ref_625mv {
> > +
> > +			adc-chan@9 {
> > 
> >   				reg = <VADC_REF_625MV>;
> >   			
> >   			};
> > 
> > -			ref_1250v {
> > +
> > +			adc-chan@10 {
> > 
> >   				reg = <VADC_REF_1250MV>;
> >   			
> >   			};
> > 
> > -			ref_buf_625mv {
> > +
> > +			adc-chan@12 {
> > 
> >   				reg = <VADC_SPARE1>;
> >   			
> >   			};
> > 
> > -			ref_gnd {
> > +
> > +			adc-chan@14 {
> > 
> >   				reg = <VADC_GND_REF>;
> >   			
> >   			};
> > 
> > -			ref_vdd {
> > +
> > +			adc-chan@15 {
> > 
> >   				reg = <VADC_VDD_VADC>;
> >   			
> >   			};
> >   		
> >   		};
> 
> I don't see where this is required, bindings doesn't mandate this naming:
> 
> patternProperties:
> 
>     "^.*@[0-9a-f]+$":

They don't require the "adc-chan" part (although dt nodes are supposed to have 
common names and adc-chan is used for adc for that; and dt node names are not 
supposed to have underscores), but this validation error happens without this 
commit:

<snip>/arch/arm/boot/dts/qcom-apq8084-ifc6540.dtb: pma8084@0: adc@3100: 
'oneOf' conditional failed, one must be fixed:
        '#address-cells', '#size-cells', 'die_temp', 'ref_1250v', 'ref_625mv', 
'ref_buf_625mv', 'ref_gnd', 'ref_vdd' do not match any of the regexes: 
'pinctrl-[0-9]+'
        'die_temp', 'ref_1250v', 'ref_625mv', 'ref_buf_625mv', 'ref_gnd', 
'ref_vdd' do not match any of the regexes: '^.*@[0-9a-f]+$', 'pinctrl-[0-9]+'
        'qcom,spmi-iadc' was expected
        From schema: <snip>/Documentation/devicetree/bindings/mfd/qcom,spmi-
pmic.yaml

So while e.g. ref-vdd@15 would also work, adc-chan@15 is more correct.

Regards
Luca


> Neil




