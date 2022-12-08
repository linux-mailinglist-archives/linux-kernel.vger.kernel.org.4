Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206916473A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLHPzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiLHPzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:55:22 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0AA528B3;
        Thu,  8 Dec 2022 07:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=qg3WTsaJ/Z5e8X1NDSgGGGfvEmzqxMJOzOEEszVTrDo=; b=rguUCBWVvKwLHP0eUjwq8aVkFX
        gerLBcC0aov8BcaD0r7xWl+9WSyHmzJo/9hoeijJvW0glM+tyMSP7CWGaEJ4VwZ0hTdgGaDu9BR4H
        jd68PpVnA3CnPUA+4VP6Gnqc6WrAIDDPj0G5bbYWy9YxGd6HhPqNXKdV4OUAr1bJZcjljnWKOSrAs
        54ib9v9fZ1dtAmLAj/MdwAQ9rgox+l/FtRlZ2J4FS5Z4zLsTGh1QzIDHrFknDz2kIQ9+QLkzj7V+O
        e+x8BdMHkR/nyTnw6Ig7jkP0eTzR1aDhO3fduwA5LYQsz1aXlMZ2cchXzGWuc2K4MLe+qFy2G5kLX
        yaKWuKbE8s+joojMQPbGHc4JbllbsbTAotM1POXG6rp6VPnmgPnFpZyBlkHo4pP1iTes96m5po9T0
        mmRKN7omED8r61BO0DGqPm5vp5G2QKJadVOVMobKo+kfACnnxQRgblc3tlKXOwO+SRGJ2Py+IJ8Ck
        eVdMzldpdvaPeYgE32517ycr2ZLRFSrTzpK6hK6MG8CQ54M/iEND7pZ4pQA4VrPmHlGt6LxPWBpJD
        sOT52eODroAKzXnW/+rzy4GvojuyEr1AITee+QJ8P/vC0SKt3li0uwxADj7Yz7WhuoooGgFyKpvmi
        WJvwLqkTWC2up0h8BZ1EFeRo1ymGDK+v2rt9Qn8BQ=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the v9fs tree
Date:   Thu, 08 Dec 2022 16:55:17 +0100
Message-ID: <6054083.7yRespAWZ4@silver>
In-Reply-To: <Y45zsz71RfXbySDq@codewreck.org>
References: <20221205150316.6fac25f2@canb.auug.org.au> <3823616.UlgstfPZBx@silver>
 <Y45zsz71RfXbySDq@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, December 5, 2022 11:41:55 PM CET Dominique Martinet wrote:
> Christian Schoenebeck wrote on Mon, Dec 05, 2022 at 09:40:06PM +0100:
> > Dominique, looking at your 9p queue, I just realized what happened here: I 
> > posted a v2 of these two patches, which got lost for some reason:
> > 
> > https://lore.kernel.org/all/cover.1669144861.git.linux_oss@crudebyte.com/
> > 
> > The currently queued 1st patch is still v1 as well.
> 
> Oh. Now how did I manage that one..
> Thanks for the catch, and v2 had the valid printf modifier...

You remember updating the 1st patch as well, right? :)

In general, I'm sure nobody complains about extra noise like "queued on...".
Then it's also more likely for other people to get which patches are still
pending or unseen.



