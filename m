Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF496DB422
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjDGTYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDGTY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:24:29 -0400
X-Greylist: delayed 555 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 Apr 2023 12:24:28 PDT
Received: from mr85p00im-zteg06011601.me.com (mr85p00im-zteg06011601.me.com [17.58.23.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADF34C01
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1680894912; bh=sCN0ZLZaOpuDDREzSVVGNNrdX8M079I3FACzOWHA1LM=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=XCJJ+hY+QJgya2ojbPZztJ/abCuufiCyiFnTjLAZa8TP27ViXVC/zuxAfX8wDjHed
         Az3uiH2dojXAA2hl+RLQvjozZ0oIPvMm/icK3pIXTecAnqpGYbEsLi/hAC6dQTq5wJ
         ojS9KNpyegMK1Oj3z+UPXKEPQ2dijFgqg5QFFle+PP/fzovG8J7pxLNQSC7uKWyb44
         WWlwbPwFmM0OZ7h7jE12PiVWYHmurQpg6BdkWrTLqwxfgucF/GPcXFvR2n1N8dLnBB
         cChE3+nXkGIN3/U3G/oFEAf0EtW6QBYcaHq0dRfY4CZz+Aw4jucATNlq8bucaULUhi
         xVuHzkNCIzA8w==
Received: from imac101 (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-zteg06011601.me.com (Postfix) with ESMTPSA id 1CCEC180D1A;
        Fri,  7 Apr 2023 19:15:10 +0000 (UTC)
Date:   Fri, 7 Apr 2023 21:15:06 +0200
From:   Alain Volmat <avolmat@me.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: mailbox: sti-mailbox: convert to DT
 schema
Message-ID: <ZDBruk2t+gB0lSEL@imac101>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230214204945.4215-1-avolmat@me.com>
 <9f2debc1-6040-3182-5945-36e668eac171@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f2debc1-6040-3182-5945-36e668eac171@linaro.org>
X-Proofpoint-GUID: He03emnZP4MyWS3seK3Oy49Oyw2W9PCE
X-Proofpoint-ORIG-GUID: He03emnZP4MyWS3seK3Oy49Oyw2W9PCE
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.816,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-18=5F01:2022-01-14=5F01,2022-01-18=5F01,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=748 spamscore=0 mlxscore=0
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2304070173
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle reminder, could someone take this patch into his branch ?

Regards,
Alain

On Wed, Feb 15, 2023 at 09:24:35PM +0100, Krzysztof Kozlowski wrote:
> On 14/02/2023 21:49, Alain Volmat wrote:
> > Convert the sti-mailbox.txt file into st,sti-mailbox.yaml
> > 
> > Signed-off-by: Alain Volmat <avolmat@me.com>
> > ---
> > v3: remove quotes around $ref
> > v2: update commit log
> >     remove quotes around urls
> >     add mbox-name $ref
> >     remove mbox-name from required properties since not mandatory in the driver
> >     fix IRQ type in example
> > 
> >  .../bindings/mailbox/st,sti-mailbox.yaml      | 53 +++++++++++++++++++
> >  .../bindings/mailbox/sti-mailbox.txt          | 51 ------------------
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 
