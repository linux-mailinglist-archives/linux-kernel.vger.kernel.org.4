Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3B56939C6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 21:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBLUQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 15:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBLUQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 15:16:14 -0500
Received: from mr85p00im-zteg06011501.me.com (mr85p00im-zteg06011501.me.com [17.58.23.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A2FE39D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 12:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1676232973; bh=l7H9Pso8xiaQY8RX76Banimb/I6jGa8Iu9uhyfnpMzE=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=S+s+lZLFwFRvA5G+2N4JdzIsDlz0NzXDA9pFpBfufI8E3ys9mhLhnQI1tOy0oE3WO
         d+k+cQs8u/SRyyRDzf6A8U76ZqoLtJghkrdD9pNT4ww9CTrhmBGWeto8AHd2abM2W2
         G0foVHzCpBlRMt39IZrrdEsK+Lx6gCVv22yOwVrbkhvyBxwiagCbc7tuz1pKTb8MiT
         AF0yW3cmFVrTyBlCQW+Met847A1Q78yF+Izikbx+rsTKV28UeGCSYcahRMon8nMCUl
         S5Mp/zCeTtfkW62ODQRC5cZej/rahMnmGmraIO4DCn9TG0mIVm2JFBstIRS/0QhQbS
         og3QFlIDeC13A==
Received: from imac101 (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-zteg06011501.me.com (Postfix) with ESMTPSA id D9742480868;
        Sun, 12 Feb 2023 20:16:11 +0000 (UTC)
Date:   Sun, 12 Feb 2023 21:16:08 +0100
From:   Alain Volmat <avolmat@me.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: arm: sti: add sti boards and remove
 stih415/stih416
Message-ID: <Y+lJCBqSAIJ01MT+@imac101>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230211210500.9919-1-avolmat@me.com>
 <20230211210500.9919-2-avolmat@me.com>
 <35ac595b-a451-870c-6e1c-613d1e817591@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35ac595b-a451-870c-6e1c-613d1e817591@linaro.org>
X-Proofpoint-ORIG-GUID: Enyxu9ZOFWHEqlIAigXruwX61lTj3clI
X-Proofpoint-GUID: Enyxu9ZOFWHEqlIAigXruwX61lTj3clI
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.816,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-18=5F01:2020-02-14=5F02,2022-01-18=5F01,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=922 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2302120186
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review

On Sun, Feb 12, 2023 at 05:02:17PM +0100, Krzysztof Kozlowski wrote:
> On 11/02/2023 22:04, Alain Volmat wrote:
> > Add bindings for STi platform boards and remove stih415/stih416 items.
> > This commit also moves the sti.yaml binding file within the arm/sti/
> > folder instead of arm/
> > 
> > Signed-off-by: Alain Volmat <avolmat@me.com>
> > ---
> >  .../devicetree/bindings/arm/sti.yaml          | 26 ---------------
> >  .../devicetree/bindings/arm/sti/sti.yaml      | 33 +++++++++++++++++++
> >  2 files changed, 33 insertions(+), 26 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/sti.yaml
> >  create mode 100644 Documentation/devicetree/bindings/arm/sti/sti.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/sti.yaml b/Documentation/devicetree/bindings/arm/sti.yaml
> > deleted file mode 100644
> > index 3ca054c64377..000000000000
> > --- a/Documentation/devicetree/bindings/arm/sti.yaml
> > +++ /dev/null
> > @@ -1,26 +0,0 @@
> > -# SPDX-License-Identifier: GPL-2.0
> > -%YAML 1.2
> > ----
> > -$id: http://devicetree.org/schemas/arm/sti.yaml#
> > -$schema: http://devicetree.org/meta-schemas/core.yaml#
> > -
> > -title: ST STi Platforms
> > -
> > -maintainers:
> > -  - Patrice Chotard <patrice.chotard@foss.st.com>
> > -
> > -properties:
> > -  $nodename:
> > -    const: '/'
> > -  compatible:
> > -    items:
> > -      - enum:
> > -          - st,stih415
> > -          - st,stih416
> > -          - st,stih407
> > -          - st,stih410
> > -          - st,stih418
> > -
> > -additionalProperties: true
> > -
> > -...
> > diff --git a/Documentation/devicetree/bindings/arm/sti/sti.yaml b/Documentation/devicetree/bindings/arm/sti/sti.yaml
> > new file mode 100644
> > index 000000000000..aefa1919207c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/sti/sti.yaml
> > @@ -0,0 +1,33 @@
> > +# SPDX-License-Identifier: GPL-2.0
> 
> Dual-license. I don't think there is anything from old binding being
> copied here (you can as well start from scratch from other binding and
> result will be the same).

Ok

I understand, based on your review of the other patch in the serie that
I should put this sti.yaml within bindings/soc/sti right ?

Moreover, I made a mistake and removed st,stih415 and st,stih416 in
this patch while I already posted the patch in the STiH415/STiH416
removal serie (https://lore.kernel.org/all/20230209091659.1409-6-avolmat@me.com/).
I propose to get rid of the patch in the other serie and do the removal
within this patch since it also moves the file.

> 
> Best regards,
> Krzysztof
> 
