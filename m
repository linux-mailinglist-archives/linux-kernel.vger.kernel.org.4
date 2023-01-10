Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEA8664E88
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjAJWJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjAJWJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:09:21 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D895E674
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 14:09:18 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230110220914euoutp02990bed1d91e1f901aba14c4c18b77f91~5EgY2_Y7O0059200592euoutp02j
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:09:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230110220914euoutp02990bed1d91e1f901aba14c4c18b77f91~5EgY2_Y7O0059200592euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673388554;
        bh=KqWEqvHobA8mHbHOeFimOvJCEgvqh/cnCiRya8pE36s=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=nqDs0ANoH0cCyBRcnI2Ye+2uC+gQ7L/dSDmaDisVHEPOYqqZjsLmIv9J4jGsknYHd
         yN5hXGG6EQotabt85KjmoeqUE36Zwmw0qHuCM8e32l7eOSTkXuZIzpfY+jHT4A/pvs
         lNnV1JHNeVPzrU1sEq4+Cbj7/Al20ON7BBCmox7o=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230110220913eucas1p2d04a69204cf000f8bbb917d0aefa5319~5EgYGhG_i0407904079eucas1p26;
        Tue, 10 Jan 2023 22:09:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 46.86.56180.902EDB36; Tue, 10
        Jan 2023 22:09:13 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230110220912eucas1p250dae7ff73fbc12e79b1149de6279a01~5EgWqT7uv0215402154eucas1p22;
        Tue, 10 Jan 2023 22:09:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230110220912eusmtrp1042ec0145d31536c7931946aa7470e02~5EgWpwpBS2004620046eusmtrp1F;
        Tue, 10 Jan 2023 22:09:12 +0000 (GMT)
X-AuditID: cbfec7f2-ab5ff7000000db74-1b-63bde209fe8c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BF.9C.52424.702EDB36; Tue, 10
        Jan 2023 22:09:11 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230110220911eusmtip2e222967415a91df0e15e528b304f06b5~5EgWRRwR-3196531965eusmtip2z;
        Tue, 10 Jan 2023 22:09:11 +0000 (GMT)
Message-ID: <66b4fb4f-35cc-1ebb-1d43-c2f942937670@samsung.com>
Date:   Tue, 10 Jan 2023 23:09:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/2] platform/chrome: cros_ec: Poll EC log on EC
 panic
Content-Language: en-US
To:     Rob Barnes <robbarnes@google.com>, groeck@chromium.org,
        pmalani@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        dtor@chromium.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230104011524.369764-2-robbarnes@google.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djP87qcj/YmG3y+I2/xdtk8RouZTdtZ
        LU69WsZscXnXHDaLqRdms1u8nb+J3YHNY3bDRRaPBZtKPV5snsno8XmTXABLFJdNSmpOZllq
        kb5dAlfG/hNT2ArOG1ecWnuWrYFxknYXIyeHhICJxMRVXaxdjFwcQgIrGCV+LL7NBpIQEvjC
        KNGwvhgi8ZlRovnAApYuRg6wjjnTYiBqljNKXH0bAlHzkVHi9ZsjTCAJXgE7iQ9tDcwgNouA
        qsTh99eYIeKCEidnPgGbIyqQIrHpTxlIWFjAX2LOnMUsIDazgLjErSfzwcaICARJtM96xwYR
        D5N4vWYn2Bg2AUOJrrddYHFOAWuJ+6dPs0LUyEs0b53NDHKPhMAZDonJFy6zQnzpIvH7xB42
        CFtY4tXxLewQtozE6ck9LBAN7YwSC37fZ4JwJgB9//wWI0SVtcSdc7/YQK5mFtCUWL9LHyLs
        KLHl+i9GSKDwSdx4KwhxBJ/EpG3TmSHCvBIdbUIQ1WoSs46vg1t78MIl5gmMSrOQQmUWkvdn
        IXlnFsLeBYwsqxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQITzel/xz/tYJz76qPeIUYm
        DsZDjBIczEoivCs59yQL8aYkVlalFuXHF5XmpBYfYpTmYFES552xdX6ykEB6YklqdmpqQWoR
        TJaJg1OqgSnKp4zhW2Csy7yD4o+em23Y98jzqvv/JZLmx2wfFDw9ZHd+5mfF39+iPj03EHb9
        Fc34zqx7z8vrB7/rFz0US8y26Y4J+xqieuxw/bY1Xt853olVz7wmFKHx5m3SqX2HdggKzYwz
        7k1JPe60ufO8x0ary+WL0tntfGS7b6cH2vpcs1p6u4b9pj6v5abcfEX+c7skLoQv/f9Vh9v+
        T7uc8cp1v22XHeJmcvbpu6IW9KHMV8D6uFJ/SOiVRZ4B6Wtkn36UTvj/b/ru3zf+L1+0ae8H
        DYNZN+SVzu7U09zn46hs37f/RnQUl5+rwoQuy+NiPzRjeBic/9i41fFvOSXTzMi0dUm4aUfD
        lac2175a5imxFGckGmoxFxUnAgD4VXkEowMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xe7rsj/YmGzx6YmPxdtk8RouZTdtZ
        LU69WsZscXnXHDaLqRdms1u8nb+J3YHNY3bDRRaPBZtKPV5snsno8XmTXABLlJ5NUX5pSapC
        Rn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G/hNT2ArOG1ecWnuW
        rYFxknYXIweHhICJxJxpMV2MnBxCAksZJfYsFgGxJQRkJE5Oa2CFsIUl/lzrYuti5AKqec8o
        seHzI3aQBK+AncSHtgZmEJtFQFXi8PtrzBBxQYmTM5+wgNiiAikSzc9Pgg0SFvCVeLf5F1gN
        s4C4xK0n85lAbBGBIIn2jb9ZIeJhEheOLGCDOChborO/HayeTcBQouttF1icU8Ba4v7p01D1
        ZhJdW7sYIWx5ieats5knMArNQnLGLCTrZiFpmYWkZQEjyypGkdTS4tz03GIjveLE3OLSvHS9
        5PzcTYzA2Np27OeWHYwrX33UO8TIxMF4iFGCg1lJhHcl555kId6UxMqq1KL8+KLSnNTiQ4ym
        wLCYyCwlmpwPjO68knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQYm
        eY0yhcR0TbuU7/+C278mcj5Pd+c0ETuy93Ta+t1venec7fXp/viQhYNHOIV348dcSx2Z/jNL
        ct+uTRbkPbT72fPZfRcjeg9M3Cv/aZdtbDKPxhfB6xs/5K2+cGGxRXybz9qXPa6rPtsF2cn/
        7Hz5u6yq7PYCX+85jzn/CRZMlXufZX6o+pr0/F62RanB0SL77XkEpzMW5BXrCs7y/5dUJuY3
        paL8oc7elqMsSku+SAo/7Zn0ojj317RHz+8afPhhPidb7JtY6hef0ruHme+vbJJ3K2g5Yf9h
        155fLycGGql5eb83fBA7adHBox+bw2wYpOVEbFeUOtlN/7Xr5dw3zSuV7shydvowa/3ojmBX
        YinOSDTUYi4qTgQAaIh6rjYDAAA=
X-CMS-MailID: 20230110220912eucas1p250dae7ff73fbc12e79b1149de6279a01
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230110220912eucas1p250dae7ff73fbc12e79b1149de6279a01
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230110220912eucas1p250dae7ff73fbc12e79b1149de6279a01
References: <20230104011524.369764-1-robbarnes@google.com>
        <20230104011524.369764-2-robbarnes@google.com>
        <CGME20230110220912eucas1p250dae7ff73fbc12e79b1149de6279a01@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 04.01.2023 02:15, Rob Barnes wrote:
> Add handler for CrOS EC panic events. When a panic is reported,
> immediately poll for EC log.
>
> This should result in the log leading to the EC panic being
> preserved.
>
> ACPI_NOTIFY_CROS_EC_PANIC is defined in coreboot at
> https://review.coreboot.org/plugins/gitiles/coreboot/+/refs/heads/master/src/ec/google/chromeec/acpi/ec.asl
>
> Signed-off-by: Rob Barnes <robbarnes@google.com>

This patch landed in today's linux-next as commit d90fa2c64d59 
("platform/chrome: cros_ec: Poll EC log on EC panic"). Unfortunately it 
introduces the following runtime warning on my test systems:

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 62 Comm: kworker/u16:1 Not tainted 
6.2.0-rc3-next-20230110-00037-g7c2b0426386a #6112
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events_unbound async_run_entry_fn
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x58/0x70
  dump_stack_lvl from register_lock_class+0x998/0x9a8
  register_lock_class from __lock_acquire+0x6c/0x2a80
  __lock_acquire from lock_acquire+0x124/0x3f0
  lock_acquire from down_write+0x40/0xd8
  down_write from blocking_notifier_chain_register+0x28/0x58
  blocking_notifier_chain_register from cros_ec_debugfs_probe+0x324/0x3b4
  cros_ec_debugfs_probe from platform_probe+0x5c/0xb8
  platform_probe from really_probe+0xe0/0x414
  really_probe from __driver_probe_device+0x9c/0x200
  __driver_probe_device from driver_probe_device+0x30/0xc0
  driver_probe_device from __device_attach_driver+0xa8/0x120
  __device_attach_driver from bus_for_each_drv+0x7c/0xc0
  bus_for_each_drv from __device_attach_async_helper+0xa0/0xf4
  __device_attach_async_helper from async_run_entry_fn+0x40/0x154
  async_run_entry_fn from process_one_work+0x288/0x790
  process_one_work from worker_thread+0x44/0x504
  worker_thread from kthread+0xf0/0x124
  kthread from ret_from_fork+0x14/0x2c
Exception stack(0xf0a6dfb0 to 0xf0a6dff8)
...
------------[ cut here ]------------

That's because the panic_notifier entry is not initialized to the sane 
value. Adding the following line:

BLOCKING_INIT_NOTIFIER_HEAD(&ec_dev->panic_notifier);

to drivers/platform/chrome/cros_ec.c to cros_ec_register() function 
fixes the issue. I will send the incremental fix in a few minutes.

> ---
>
> Changelog since v1:
> - Split into two patches
> - Moved panic handle before mkbp loop
> - Switched to dev_emerg message
>
>   drivers/platform/chrome/cros_ec_debugfs.c   | 23 +++++++++++++++++++++
>   drivers/platform/chrome/cros_ec_lpc.c       |  7 +++++++
>   include/linux/platform_data/cros_ec_proto.h |  9 ++++++++
>   3 files changed, 39 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> index 21d973fc6be2..34f7b46f8761 100644
> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> @@ -49,6 +49,7 @@ struct cros_ec_debugfs {
>   	struct delayed_work log_poll_work;
>   	/* EC panicinfo */
>   	struct debugfs_blob_wrapper panicinfo_blob;
> +	struct notifier_block notifier_panic;
>   };
>   
>   /*
> @@ -437,6 +438,22 @@ static int cros_ec_create_panicinfo(struct cros_ec_debugfs *debug_info)
>   	return ret;
>   }
>   
> +static int cros_ec_debugfs_panic_event(struct notifier_block *nb,
> +				       unsigned long queued_during_suspend, void *_notify)
> +{
> +	struct cros_ec_debugfs *debug_info =
> +		container_of(nb, struct cros_ec_debugfs, notifier_panic);
> +
> +	if (debug_info->log_buffer.buf) {
> +		/* Force log poll work to run immediately */
> +		mod_delayed_work(debug_info->log_poll_work.wq, &debug_info->log_poll_work, 0);
> +		/* Block until log poll work finishes */
> +		flush_delayed_work(&debug_info->log_poll_work);
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
>   static int cros_ec_debugfs_probe(struct platform_device *pd)
>   {
>   	struct cros_ec_dev *ec = dev_get_drvdata(pd->dev.parent);
> @@ -473,6 +490,12 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
>   	debugfs_create_u16("suspend_timeout_ms", 0664, debug_info->dir,
>   			   &ec->ec_dev->suspend_timeout_ms);
>   
> +	debug_info->notifier_panic.notifier_call = cros_ec_debugfs_panic_event;
> +	ret = blocking_notifier_chain_register(&ec->ec_dev->panic_notifier,
> +					       &debug_info->notifier_panic);
> +	if (ret)
> +		goto remove_debugfs;
> +
>   	ec->debug_info = debug_info;
>   
>   	dev_set_drvdata(&pd->dev, ec);
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index 7fc8f82280ac..5738f1d25091 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -320,6 +320,13 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
>   
>   	ec_dev->last_event_time = cros_ec_get_time_ns();
>   
> +	if (value == ACPI_NOTIFY_CROS_EC_PANIC) {
> +		dev_emerg(ec_dev->dev, "CrOS EC Panic Reported. Shutdown is imminent!");
> +		blocking_notifier_call_chain(&ec_dev->panic_notifier, 0, ec_dev);
> +		/* Do not query for other events after a panic is reported */
> +		return;
> +	}
> +
>   	if (ec_dev->mkbp_event_supported)
>   		do {
>   			ret = cros_ec_get_next_event(ec_dev, NULL,
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index e43107e0bee1..7fb2196f99b0 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -41,6 +41,13 @@
>   #define EC_MAX_REQUEST_OVERHEAD		1
>   #define EC_MAX_RESPONSE_OVERHEAD	32
>   
> +/*
> + * EC panic is not covered by the standard (0-F) ACPI notify values.
> + * Arbitrarily choosing B0 to notify ec panic, which is in the 84-BF
> + * device specific ACPI notify range.
> + */
> +#define ACPI_NOTIFY_CROS_EC_PANIC 0xB0
> +
>   /*
>    * Command interface between EC and AP, for LPC, I2C and SPI interfaces.
>    */
> @@ -176,6 +183,8 @@ struct cros_ec_device {
>   	/* The platform devices used by the mfd driver */
>   	struct platform_device *ec;
>   	struct platform_device *pd;
> +
> +	struct blocking_notifier_head panic_notifier;
>   };
>   
>   /**

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

