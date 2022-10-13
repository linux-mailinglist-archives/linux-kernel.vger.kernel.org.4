Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3EC5FD64B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 10:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJMIiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 04:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJMIiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 04:38:13 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D71410692D;
        Thu, 13 Oct 2022 01:38:12 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 347641E80D99;
        Thu, 13 Oct 2022 16:38:14 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 43ijxjZJcuHU; Thu, 13 Oct 2022 16:38:11 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 89CEC1E80D90;
        Thu, 13 Oct 2022 16:38:11 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     damien.lemoal@opensource.wdc.com
Cc:     jejb@linux.vnet.ibm.com, kunyu@nfschina.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, yanaijie@huawei.com
Subject: Re: [PATCH 4.19] scsi: sd: Fix 'sdkp' in sd_first_printk
Date:   Thu, 13 Oct 2022 16:37:35 +0800
Message-Id: <20221013083736.279312-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <035b7855-b6fc-5604-7969-7b356ffa33e3@opensource.wdc.com>
References: <035b7855-b6fc-5604-7969-7b356ffa33e3@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I see. I will send it after I understand the steps.

