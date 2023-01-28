Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C734A67F729
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjA1Kit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjA1Kir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:38:47 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DDF7752A;
        Sat, 28 Jan 2023 02:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1674902315; bh=Qf1j0H73Nv8f2iy3YuNlNYJSuoKVTL34r6A9vrjmjk8=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=YHVjWbSFlyv5MgHKTMxmxcUrL+mSNCu6IqISx32ObU6bAeZ0bL/fBKni6t5R9LW24
         Xwav1oBmWonskrp3SJsom4eXreP3kbbt3REBOonPtOxnnYnMSC58Pl5b+Txh6yVIkn
         XADUf+LX8xx7C+M04q7pyRL8TZ9nMq+F0kFxwOGg=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 28 Jan 2023 11:38:35 +0100 (CET)
X-EA-Auth: ZizyT+JKiUVNqc1hAoM1JFLj/hxNuqa2tHITJgmEKqR5OIhY+AUGsbPXjaTRUX5bgePdTS5CQxY0U3ys2ggAXC0c5tX502q0
Date:   Sat, 28 Jan 2023 16:08:31 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH 0/2] scsi: megaraid/megaraid_sas: Use max helper for
 comparison and assignment
Message-ID: <cover.1674900575.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set proposes to replace the current if/else or "? :" based logical
evaluation and value assignment by the recommended max() helper macro. Resultant
code is better in terms of type checking and improved readability. 

Deepak R Varma (2):
  scsi: megaraid: Use max helper for comparison and assignment
  scsi: megaraid_sas: Use max helper for comparison and assignment

 drivers/scsi/megaraid.c                   | 3 +--
 drivers/scsi/megaraid/megaraid_sas_base.c | 5 +----
 2 files changed, 2 insertions(+), 6 deletions(-)

-- 
2.34.1



