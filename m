Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6F8718487
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbjEaOQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237621AbjEaOPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:15:46 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C878718D;
        Wed, 31 May 2023 07:13:20 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V5CpaG031404;
        Wed, 31 May 2023 09:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=DfcZshtC/3kePJgZElnsMbSUMBBpHznHMh0D64IdoII=;
 b=ApqQ+JFfSzg+1JB9vTTtQ6kONI8wr2UWK94lbyvCuEPStuZp7bhenjNYydsOQrbr5cW9
 QOeLN+yWeBz+VuHFGE3W0W+IIpeH4c0Gz4lIMFAm+vj+RRdn7QPmycW6j08R/dHZ/qFs
 7ldmOfOGYsgkGbI4kSbTr7q3WdgUkBR4YdWzgzTseHkNtB5IgncTzjDVi9cxQaDFRb+K
 QZR6u8tTT3IrbG4Q6QdABwZRbLTRkK3hJjGkmu7RqkvUhv26RrjiqdN1GM5Bl/w8a6Td
 ep+DcqVcOsaWKRNeU7dEo9Fd0R27E4SIvL13c1KS1IMbhJ1ZFwrNnRvyt8c9MgVf+1oh tQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3que9mvtw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 09:12:09 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 31 May
 2023 15:12:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 31 May 2023 15:12:07 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 598FD475;
        Wed, 31 May 2023 14:12:07 +0000 (UTC)
Date:   Wed, 31 May 2023 14:12:07 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <broonie@kernel.org>, <lee@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <vkoul@kernel.org>, <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <lgirdwood@gmail.com>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: sound: cirrus,cs42l43: Add initial
 DT binding
Message-ID: <20230531141207.GJ68926@ediswmail.ad.cirrus.com>
References: <20230530122112.1314458-1-ckeepax@opensource.cirrus.com>
 <20230530122112.1314458-3-ckeepax@opensource.cirrus.com>
 <eef819db-4de3-06fe-8fe6-b0fe87ab5d84@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <eef819db-4de3-06fe-8fe6-b0fe87ab5d84@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: hIXSRhjnKWNOVq-ly_WiPUo81d5fSQGO
X-Proofpoint-ORIG-GUID: hIXSRhjnKWNOVq-ly_WiPUo81d5fSQGO
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 11:02:24AM +0200, Krzysztof Kozlowski wrote:
> On 30/05/2023 14:21, Charles Keepax wrote:
> > +  cirrus,bias-sense-ua:
> 
> "ua" looks like microamp. If so, microamp instead:
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
> 
> > +  pinctrl:
> > +    type: object
> > +
> > +    allOf:
> 
> Drop allOf, just "$ref: ......"
> 
> > +      - $ref: /schemas/pinctrl/pinctrl.yaml#
> > +
> > +    additionalProperties: false
> 
> Also drop blank lines between these three above.
> 
> > +    patternProperties:
> > +      "-state$":
> 
> Use consistent quotes, either " or ' everywhere
> 

Thanks, will fix those all up for v3.

Thanks,
Charles
