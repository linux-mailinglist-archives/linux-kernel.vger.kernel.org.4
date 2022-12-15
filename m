Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF94664D785
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 09:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiLOIHn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Dec 2022 03:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLOIHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 03:07:40 -0500
Received: from mx3.uni-regensburg.de (mx3.uni-regensburg.de [194.94.157.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34C91F624;
        Thu, 15 Dec 2022 00:07:37 -0800 (PST)
Received: from mx3.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 1E6F7600005B;
        Thu, 15 Dec 2022 09:07:35 +0100 (CET)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx3.uni-regensburg.de (Postfix) with ESMTP id 08156600004D;
        Thu, 15 Dec 2022 09:07:30 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Thu, 15 Dec 2022 09:07:31 +0100
Message-Id: <639AD5C0020000A100050749@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.4.2 
Date:   Thu, 15 Dec 2022 09:07:28 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <haowenchao@huawei.com>
Cc:     "open-iscsi" <open-iscsi@googlegroups.com>,
        <linfeilong@huawei.com>, <liuzhiqiang26@huawei.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <michael.christie@oracle.com>, "Chris Leech" <cleech@redhat.com>,
        "Lee Duncan" <lduncan@suse.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
Subject: Antw: [EXT] Re: [PATCH 0/2] scsi:donot skip lun if inquiry
 returns PQ=1 for all hosts
References: <20221214070846.1808300-1-haowenchao@huawei.com>
 <Y5rHX95Vvl1aLhbp@infradead.org>
In-Reply-To: <Y5rHX95Vvl1aLhbp@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Christoph Hellwig <hch@infradead.org> schrieb am 15.12.2022 um 08:06 in
Nachricht <Y5rHX95Vvl1aLhbp@infradead.org>:
> On Wed, Dec 14, 2022 at 03:08:44PM +0800, Wenchao Hao wrote:
>> When iSCSI initiator logged in target, the target attached none valid
>> lun but lun0. lun0 is not an valid disk, while it would response
>> inquiry command with PQ=1 and other general scsi commands like probe lun.
>> The others luns of target is added/removed dynamicly.
> 
> I can't find any special casing of LUN0 in RFC7144, can you clarify
> where you think that treats LUN0 any differently than other transports?

Actusally I have no idea, but as a user of FC SAN systems I can remember a case when a storage system had to present a dummy LUN0 to enable hosts to find other LUNs (while LUN0 was never actually used). Maybe the client code was imperfect, I don't know.

> 
> -- 
> You received this message because you are subscribed to the Google Groups 
> "open-iscsi" group.
> To unsubscribe from this group and stop receiving emails from it, send an 
> email to open-iscsi+unsubscribe@googlegroups.com.
> To view this discussion on the web visit 
> https://groups.google.com/d/msgid/open-iscsi/Y5rHX95Vvl1aLhbp%40infradead.org 
> .




