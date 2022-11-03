Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28CB61869C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiKCRut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiKCRur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:50:47 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5621125;
        Thu,  3 Nov 2022 10:50:46 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A3Hof1i015948;
        Thu, 3 Nov 2022 12:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667497841;
        bh=mVzOCXZ/VP+bmK6osGPtfkcgoYusObAY9VW4cEM5G7A=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=YeWj0SjQ9fnDCm04+PunRuIlffzFw09CvMB0AY8QN5VOSU9QVxIomQsdHrqamGZyk
         c/8LoNnaVukHfo9OzEobt9cLqRqeiORK+m3+8DaQQeU0BJDmrlygNIETipn/EspYRo
         cis68wn9PPGWLGy+gcrDzDUSEvEFanvoXHzkkxbk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A3Hoffw032746
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Nov 2022 12:50:41 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 3 Nov
 2022 12:50:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 3 Nov 2022 12:50:41 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A3HodcD093039;
        Thu, 3 Nov 2022 12:50:40 -0500
Date:   Thu, 3 Nov 2022 23:20:39 +0530
From:   Rahul T R <r-ravikumar@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jkridner@gmail.com>
Subject: Re: [PATCH v6 0/2] Enable RPi header on j721e sk
Message-ID: <20221103175038.hhs3ltvghljihou2@uda0490373>
References: <20221021172932.16731-1-r-ravikumar@ti.com>
 <20221103044111.hui7wya64fzjxfgp@wrongdoer>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221103044111.hui7wya64fzjxfgp@wrongdoer>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 23:41-20221102, Nishanth Menon wrote:
> On 22:59-20221021, Rahul T R wrote:
> > The following series of patches enables RPi header
> > on j721e sk. It is a 40 pin io expasion header which
> > brings out i2c5, ehrpwm 2,3 and some pins of gpio 0,1
> > 
> > v6:
> >    - Rebased to 6.1-rc1
> 
> Now that the cleanups are in place, we'd need one additional rebase
> please.
> 

I have rebased and sent v7

Regards
Rahul T R

> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
