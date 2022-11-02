Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF1C616564
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiKBO6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKBO5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:57:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807C727DC1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 07:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=YEDQIsp0qvgv9l8wUosVLZHSR6rRP/sLKVEBMN6Xw4g=; b=hOYio3OINzGixasO2FArUcbyt7
        glE5MKG1df+6hWFkLqOEuS6qQL1NfagBxWrCo+FE2GRqz8RqdXHtQ+GLE5MVpVjpzs4CdPfnYtLk2
        h74fzSEaNN+aBfnGD3/kIIYPPzEj14AhEgs4+JRkEbehDlbaHLII/9xHxON7BgoApMa7znFyaJ4yT
        4HHYWrX9vJNypWzOnOVbSPuFOhUrNX8tlr0V/TDgubOmCyQOeGa3n1PjAehymXM870u2+0VzaXgUi
        S9fEul8LQerL3W4Rz2Zk+uqW8nDN0vv1CJ3Y2NqA5vh/1/xoX5JIRZXHMFeoN4oDyi1UVrqxZauqY
        F4aZOk2w==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqFBW-00BcdW-67; Wed, 02 Nov 2022 14:57:42 +0000
Message-ID: <b7ade603-10dc-51fc-4b83-45f0476dbae7@infradead.org>
Date:   Wed, 2 Nov 2022 07:57:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] platform/x86: ISST: Fix typo in comments
Content-Language: en-US
To:     chen zhang <chenzhang@kylinos.cn>, hdegoede@redhat.com
Cc:     linux-kernel@vger.kernel.org, chenzhang_0901@163.com,
        k2ci <kernel-bot@kylinos.cn>
References: <20221102060654.34114-1-chenzhang@kylinos.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221102060654.34114-1-chenzhang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 11/1/22 23:06, chen zhang wrote:
> Fix spelling typo in comments. Change "interace" to "interface".
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: chen zhang <chenzhang@kylinos.cn>
> ---
> v2: update the commit
> There is a bug with my company's mailbox with kylinos.cn, and sometimes 
> I can't receive reply emails. I cc my personal 163 mailbox, so that I can
> receive feedback from reviewer on time.
> ---
>  drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> index fd102678c75f..c1d7f4f38765 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> @@ -623,7 +623,7 @@ static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
>  
>  /* Lock to prevent module registration when already opened by user space */
>  static DEFINE_MUTEX(punit_misc_dev_open_lock);
> -/* Lock to allow one share misc device for all ISST interace */
> +/* Lock to allow one share misc device for all ISST interface */

How about:

+/* Lock to allow one shared misc device for all ISST interfaces */

>  static DEFINE_MUTEX(punit_misc_dev_reg_lock);
>  static int misc_usage_count;
>  static int misc_device_ret;

-- 
~Randy
