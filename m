Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8623E673274
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjASHaO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Jan 2023 02:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjASH2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:28:13 -0500
X-Greylist: delayed 579 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Jan 2023 23:28:12 PST
Received: from mail.redfish-solutions.com (mail.redfish-solutions.com [24.116.100.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893D1604B0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:28:11 -0800 (PST)
Received: from smtpclient.apple (macbook3-2.redfish-solutions.com [192.168.8.12])
        (authenticated bits=0)
        by mail.redfish-solutions.com (8.17.1/8.16.1) with ESMTPSA id 30J7Hsf3769655
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 00:17:54 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH v4 0/2] Expand APU2 driver to 3/4/5/6 models
From:   Philip Prindeville <philipp@redfish-solutions.com>
In-Reply-To: <44e0ef20-d6d3-4c87-1828-f88dbc08e942@redhat.com>
Date:   Thu, 19 Jan 2023 00:17:21 -0700
Cc:     platform-driver-x86@vger.kernel.org, linux-x86_64@vger.kernel.org,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Ed Wildgoose <lists@wildgooses.com>,
        Andres Salomon <dilinger@queued.net>,
        Andreas Eberlein <foodeas@aeberlein.de>,
        Paul Spooren <paul@spooren.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <343F820D-69E1-4120-89DA-980FC78E3656@redfish-solutions.com>
References: <20230113231139.436943-1-philipp@redfish-solutions.com>
 <44e0ef20-d6d3-4c87-1828-f88dbc08e942@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Scanned-By: MIMEDefang 3.2 on 192.168.8.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 17, 2023, at 3:25 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> 
> Hi Philip,
> 
> On 1/14/23 00:11, Philip Prindeville wrote:
>> From: Philip Prindeville <philipp@redfish-solutions.com>
>> 
>> Extend PCEngines APU2 driver to derivative models APU3, 4, 5
>> and 6.
>> 
>> Of the five, the APU5 is the most dissimilar.  The APU2 is not
>> derivative of the APU1, and we call that out in the leds-apu
>> driver.  We also clarify the expanded compatibility of the
>> pcengines-apuv2 driver in the Kconfig menu.
>> 
>> We correct some line labeling for GPIO lines 4-6, and we add
>> appropriate definitions to the GPIO lines for the APU5 which
>> is mapped out differently.
>> 
>> The majority of the work was done by Ed Wildgoose.  Philip
>> Prindeville took over the effort to upstream the fixes and
>> made some minor cleanup.
> 
> Thank you both for your work on this.
> 
> In would really like to hear back from Enrico what he thinks
> about these patches. FWIW I'm fine with merging these as is.
> 
> Also note that Enrico is listed as maintainer for the 
> pcengines-apuv2.c file in MAINTAINERS, so you really should
> have Cc-ed him on this.
> 
> Enrico, can you take a look at this series please? You can find
> the 2 actual patches here:
> 
> https://lore.kernel.org/platform-driver-x86/20230113231139.436956-1-philipp@redfish-solutions.com/
> https://lore.kernel.org/platform-driver-x86/20230113231140.437040-1-philipp@redfish-solutions.com/
> 
> Regards,
> 
> Hans


I tried to copy Enrico on earlier revisions of this patch but they bounced so I stopped including him.

-Philip


> 
> 
>> 
>> Philip Prindeville (2):
>>  x86: Support APU5 & APU6 in PCEngines platform driver
>>  x86: Further PCEngines APU4/5/6 cleanup
>> 
>> drivers/leds/leds-apu.c                |   2 +-
>> drivers/platform/x86/Kconfig           |   4 +-
>> drivers/platform/x86/pcengines-apuv2.c | 118 ++++++++++++++++++++++---
>> 3 files changed, 107 insertions(+), 17 deletions(-)
>> 
> 

