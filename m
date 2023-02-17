Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483AF69A607
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 08:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBQHYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 02:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBQHYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 02:24:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442245D3F6;
        Thu, 16 Feb 2023 23:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=JCLmCLtas4GQHs6GzTWyZXyGRcoQonfb6f6g4zTl7mk=; b=JcRsuweSBKNMamLCp3n1/WeH0Q
        aIlQQx3jTuq3hRIHSAgmGfxUlSjTE8QU8siwamEQiFf6Uu/f4VYwOHO4fuXDPTKlS1WR1egM6viya
        F7V61fTY4sGIxFcJzyjDlU3n+dHLAVM7rJdXXjfv7FmU9m21UTUlY7rMEHR7DtHIwNyjhQsdEWfw3
        Ps3g+Ck/p5EHS+D9fIpoLT5ZfIUsY91vQzVbmT62zrflNqMTIrKYh5z6+v/++WLBWoBt9otQCb8mD
        itC1wq7ThqwqUP2LV97D4qh3tVihdzWUIIBA17UsX0WlpGAoQ83u4Yb3q4WzABvQkwDVPhzBck5Xi
        eQLQfYJw==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSv6O-00D4UK-Dn; Fri, 17 Feb 2023 07:24:16 +0000
Message-ID: <538fa87c-63c7-fe27-d466-796f3fc1e6c2@infradead.org>
Date:   Thu, 16 Feb 2023 23:24:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] scsi: lpfc: Fix double word in comments
Content-Language: en-US
To:     Bo Liu <liubo03@inspur.com>, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230217071705.2857-1-liubo03@inspur.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230217071705.2857-1-liubo03@inspur.com>
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

Hi--

On 2/16/23 23:17, Bo Liu wrote:
> Remove the repeated word "the" in comments.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  drivers/scsi/lpfc/lpfc_attr.c    | 10 +++++-----
>  drivers/scsi/lpfc/lpfc_els.c     |  2 +-
>  drivers/scsi/lpfc/lpfc_hbadisc.c |  2 +-
>  drivers/scsi/lpfc/lpfc_init.c    |  4 ++--
>  drivers/scsi/lpfc/lpfc_mbox.c    |  4 ++--
>  drivers/scsi/lpfc/lpfc_nvmet.c   |  2 +-
>  drivers/scsi/lpfc/lpfc_sli.c     |  2 +-
>  7 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
> index 76c3434f8976..1a32b3f93d77 100644
> --- a/drivers/scsi/lpfc/lpfc_attr.c
> +++ b/drivers/scsi/lpfc/lpfc_attr.c
> @@ -2541,7 +2541,7 @@ lpfc_sriov_hw_max_virtfn_show(struct device *dev,
>  
>  /**
>   * lpfc_enable_bbcr_set: Sets an attribute value.
> - * @phba: pointer the the adapter structure.

             pointer to the adapter structure.

Same for all of these:

> + * @phba: pointer the adapter structure.
>   * @val: integer attribute value.
>   *
>   * Description:
> @@ -2632,7 +2632,7 @@ lpfc_##attr##_show(struct device *dev, struct device_attribute *attr, \
>   * takes a default argument, a minimum and maximum argument.
>   *
>   * lpfc_##attr##_init: Initializes an attribute.
> - * @phba: pointer the the adapter structure.
> + * @phba: pointer the adapter structure.
>   * @val: integer attribute value.
>   *
>   * Validates the min and max values then sets the adapter config field
> @@ -2665,7 +2665,7 @@ lpfc_##attr##_init(struct lpfc_hba *phba, uint val) \
>   * into a function with the name lpfc_hba_queue_depth_set
>   *
>   * lpfc_##attr##_set: Sets an attribute value.
> - * @phba: pointer the the adapter structure.
> + * @phba: pointer the adapter structure.
>   * @val: integer attribute value.
>   *
>   * Description:
> @@ -2794,7 +2794,7 @@ lpfc_##attr##_show(struct device *dev, struct device_attribute *attr, \
>   * lpfc_##attr##_init: validates the min and max values then sets the
>   * adapter config field accordingly, or uses the default if out of range
>   * and prints an error message.
> - * @phba: pointer the the adapter structure.
> + * @phba: pointer the adapter structure.
>   * @val: integer attribute value.
>   *
>   * Returns:
> @@ -2826,7 +2826,7 @@ lpfc_##attr##_init(struct lpfc_vport *vport, uint val) \
>   * lpfc_##attr##_set: validates the min and max values then sets the
>   * adapter config field if in the valid range. prints error message
>   * and does not set the parameter if invalid.
> - * @phba: pointer the the adapter structure.
> + * @phba: pointer the adapter structure.
>   * @val:	integer attribute value.
>   *
>   * Returns:



> diff --git a/drivers/scsi/lpfc/lpfc_mbox.c b/drivers/scsi/lpfc/lpfc_mbox.c
> index 9858b1743769..cebb3d7598e5 100644
> --- a/drivers/scsi/lpfc/lpfc_mbox.c
> +++ b/drivers/scsi/lpfc/lpfc_mbox.c
> @@ -2509,7 +2509,7 @@ lpfc_sli4_dump_page_a0(struct lpfc_hba *phba, struct lpfcMboxq *mbox)
>   * information via a READ_FCF mailbox command. This mailbox command also is used
>   * to indicate where received unsolicited frames from this FCF will be sent. By
>   * default this routine will set up the FCF to forward all unsolicited frames
> - * the the RQ ID passed in the @phba. This can be overridden by the caller for

      to the

> + * the RQ ID passed in the @phba. This can be overridden by the caller for
>   * more complicated setups.
>   **/
>  void
> @@ -2577,7 +2577,7 @@ lpfc_reg_fcfi(struct lpfc_hba *phba, struct lpfcMboxq *mbox)
>   * information via a READ_FCF mailbox command. This mailbox command also is used
>   * to indicate where received unsolicited frames from this FCF will be sent. By
>   * default this routine will set up the FCF to forward all unsolicited frames
> - * the the RQ ID passed in the @phba. This can be overridden by the caller for

      to the

> + * the RQ ID passed in the @phba. This can be overridden by the caller for
>   * more complicated setups.
>   **/
>  void

-- 
~Randy
