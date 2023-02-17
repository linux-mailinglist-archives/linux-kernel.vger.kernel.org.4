Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D967569B0FC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjBQQcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjBQQcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:32:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E092172936;
        Fri, 17 Feb 2023 08:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=XHYGSp+R2NnQ++mczB+FUJo+gLmzgF5t6LdIKcLbrX8=; b=hHQbyIndp4HRRlRzbJcMSVU/lh
        FDnVr+OF5SQMZrFINYjYHNcx8HQ8RFLUFmKkUrFZRLBytELib59qwQ660ZjOJV9ue80nEfowL8uK9
        EfmZHaW5XhHWZxPbnZlBWcwS1tJoUJEcypXxiyBDQBym9ez2dq/7ZHEzei0aIeGezdGtNrQcCeFjA
        WfpPA+SdDujDyjcV/ZSGLd/a5LBQOusqjmWyV/qB8Gi7H/yRmGXZmQHKDhVvCwl5cKtwHU4G4XmWN
        UX+PAPyAO4vN7Ok2SfRNcWlqT24G5hzQavxQaT8Be4RN01zBD1zlGMoKP1rOgGEhO8UxDzP7kD47J
        os9thz5A==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pT3dr-00F4KU-1u; Fri, 17 Feb 2023 16:31:23 +0000
Message-ID: <4cd6d9cf-abf8-bf2a-9942-472c8b43d344@infradead.org>
Date:   Fri, 17 Feb 2023 08:31:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/1] scsi: lpfc: Fix double word in comments
Content-Language: en-US
To:     Bo Liu <liubo03@inspur.com>, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230217083046.4090-1-liubo03@inspur.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230217083046.4090-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/17/23 00:30, Bo Liu wrote:
> Remove the repeated word "the" in comments.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

These changes all look good to me.

There are quite a few typos/spellos of other words remaining,
but they were not the target of this patch...

Thanks.

> ---
>  drivers/scsi/lpfc/lpfc_attr.c    | 10 +++++-----
>  drivers/scsi/lpfc/lpfc_els.c     |  2 +-
>  drivers/scsi/lpfc/lpfc_hbadisc.c |  2 +-
>  drivers/scsi/lpfc/lpfc_init.c    |  4 ++--
>  drivers/scsi/lpfc/lpfc_mbox.c    |  4 ++--
>  drivers/scsi/lpfc/lpfc_nvmet.c   |  2 +-
>  drivers/scsi/lpfc/lpfc_sli.c     |  2 +-
>  7 files changed, 13 insertions(+), 13 deletions(-)


-- 
~Randy
