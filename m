Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E41F6F4BE8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 23:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjEBVNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 17:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjEBVNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 17:13:30 -0400
X-Greylist: delayed 593 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 May 2023 14:13:29 PDT
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608F810EA
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 14:13:29 -0700 (PDT)
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CE46F5C1025
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 21:03:36 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id AED27940078
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 21:03:34 +0000 (UTC)
Received: from [192.168.100.231] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id AE8BF13C2B0
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 14:03:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com AE8BF13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1683061413;
        bh=1rBHR3AumzGnBNWotHRF7Plhb+WSPhhn1pTZsHiHuqc=;
        h=Date:To:From:Subject:From;
        b=j1N0YsmPibhhmaa3UKjOun1HD4FLKMC3agNkcmOQ/rFqNGBizA1kIMhU/M5lLqfml
         oGEGsPMUTqThcu8XzSJLg47RHrtI/6t85j+G4G/fgX0rkUSygY1J2hF8JOfEUWrkm6
         PyJkfq8p0Acn+8ZpheZuedDjurY6Fr9UKvnTtyT8=
Message-ID: <9d87defc-5376-d690-b483-bc314e4f568b@candelatech.com>
Date:   Tue, 2 May 2023 14:03:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-MW
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: Hang loading initrd since last Friday.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1683061415-4knxQQTeyimb
X-MDID-O: us5;at1;1683061415;4knxQQTeyimb;<greearb@candelatech.com>;c71d53d8b4bf163c84f4470b0e4d7294
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Pulling today's upstream 6.3+ tree, my system now hangs loading initrd.  Nothing useful is seen on
serial console after that.  This was working late last week.  Other older kernels boot OK, so
I think is is related to the kernel.

I have not yet started bisect, curious if this is already know problem.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
