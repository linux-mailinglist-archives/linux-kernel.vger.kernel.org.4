Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C05D72B9C8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjFLIH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbjFLIGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:06:55 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD5AB5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:06:11 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230612075251epoutp02ccfcaf6f93d4576bd735af88c4b101cd~n2hWh94xt1845518455epoutp02c
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:52:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230612075251epoutp02ccfcaf6f93d4576bd735af88c4b101cd~n2hWh94xt1845518455epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686556371;
        bh=URaC+fwzwBBWdu87ez64/DWs/qxRMF1AQRsVSgmOwoM=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=q2XSW5c4dKbZMDdN+GugjF1JRDhhWxJU0Paqcqb74ENF5a/l1SOS6PVImTVPPC5is
         F0+3WwhYyilkZfGQE9/5sHRV1oj68aaEAqo03QcuigIz7P9hMWNcXTzs8rNeWjkUma
         WUXNT9Vn4Q8xJKW7J/rKOmKsxfnVFmWnNw6eOtK0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230612075251epcas2p3a7f046b80cc23f5f28fb5dd4b031bcff~n2hWCgJMr2111021110epcas2p3q;
        Mon, 12 Jun 2023 07:52:51 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.89]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QfkSL6GG2z4x9Q9; Mon, 12 Jun
        2023 07:52:50 +0000 (GMT)
X-AuditID: b6c32a48-c3ff87000000acbc-ef-6486ced2ce9e
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.BE.44220.2DEC6846; Mon, 12 Jun 2023 16:52:50 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH] f2fs: including waf data in f2fs status information
Reply-To: beomsu7.kim@samsung.com
Sender: beomsu kim <beomsu7.kim@samsung.com>
From:   beomsu kim <beomsu7.kim@samsung.com>
To:     Chao Yu <chao@kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yonggil Song <yonggil.song@samsung.com>,
        Seokhwan Kim <sukka.kim@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Seonghun Kim <seonghun-sui.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <f301845f-c358-4632-1df5-5944d7483072@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230612075250epcms2p7d2e02243caa54d4a9ceb525a2b23d555@epcms2p7>
Date:   Mon, 12 Jun 2023 16:52:50 +0900
X-CMS-MailID: 20230612075250epcms2p7d2e02243caa54d4a9ceb525a2b23d555
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdljTVPfSubYUg8XdWhanp55lslj1INzi
        yfpZzBaXFrlbXN41h83i9Q85i1Udcxktpp4/wuTA4bFpVSebx+4Fn5k8+rasYvT4vEkugCUq
        2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AYlhbLE
        nFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToF5gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG
        3C0LWAoOC1ccmfCQrYFxI18XIyeHhICJxIMz/cxdjFwcQgI7GCXmPp7L1MXIwcErICjxd4cw
        SI2wgLfE6hv/WUBsIQFFib7mDWwgJcICOhJLthiDhNkEtCS6r58BGyMi0MEssW/7W0aI+bwS
        M9qfskDY0hLbl28Fi3MK2Ek8b/vADhHXkPixrJcZwhaVuLn6LTuM/f7YfKg5IhKt985C1QhK
        PPi5GyouIfH652WoeL7E998fGUGOkBBoYZTY2TMHKqEvse3PbLAjeAV8JV40bGQFeYBFQFVi
        79xsiBIXiY+794OVMAvIS2x/C9LKAWRrSqzfpQ9iSggoSxy5BVXBJ9Fx+C87zIc75j1hgihR
        legGBQ472LMdBhAFHhIfH91ggQTxSUaJmT0XWScwKsxChPIsJFtnIWxdwMi8ilEstaA4Nz21
        2KjABB6xyfm5mxjBSVHLYwfj7Lcf9A4xMnEwHmKU4GBWEuHVNmlOEeJNSaysSi3Kjy8qzUkt
        PsRoCvTuRGYp0eR8YFrOK4k3NLE0MDEzMzQ3MjUwVxLn/dihnCIkkJ5YkpqdmlqQWgTTx8TB
        KdXA5LM0lfnUyrbt5cIvmFbsPPPQISPtVb3f4xcVxWkT1r5c+jDn5Paj18pm9iZuWjM/e93P
        G1Znfrtqyxrs9WGqaZN6q8Nqu5vtBLMIS1bnQaXzki5qec5/Lks5ssyZHSTxbPrK2VdLNAQ5
        K+V6N7/9zB0pW62wzvR7oYL2U9V7F3OWipb0Sb7Iyzn+SY8xL3TV5Jr1vN8LPn+tfrikutJu
        a/yne1ckyhyW2jAnz/vPnb/t5mtt69uyJ5m8YxJ81ndWfTey+3jQa11++aL7SQpF7y/7BEjd
        FziyZfUr2VtKl4PYtSw/ZhZxCG3US5t42vfdj6ITK3bET+Tg4L9o+7vUYZKRxfcFEp69Pxi/
        1tzwVGIpzkg01GIuKk4EAIpujO8TBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230602044830epcms2p141ec782e866c2adc5a3142516f051b87
References: <f301845f-c358-4632-1df5-5944d7483072@kernel.org>
        <20230602044830epcms2p141ec782e866c2adc5a3142516f051b87@epcms2p1>
        <CGME20230602044830epcms2p141ec782e866c2adc5a3142516f051b87@epcms2p7>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/2 12:48, beomsu kim wrote:
>> When evaluating in f2fs, it takes much time to obtain waf data.
>> This patch helps to obtain waf data without calcluation.
>> 
>> Signed-off-by: Beomsu Kim <beomsu7.kim@samsung.com>
>> ---
>>   fs/f2fs/iostat.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>> 
>> diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
>> index 3d5bfb1ad585..6eab11b0610d 100644
>> --- a/fs/f2fs/iostat.c
>> +++ b/fs/f2fs/iostat.c
>> @@ -34,10 +34,22 @@ int __maybe_unused iostat_info_seq_show(struct seq_file *seq, void *offset)
>>   {
>>          struct super_block *sb = seq->private;
>>          struct f2fs_sb_info *sbi = F2FS_SB(sb);
>> +       int j;
>> +       unsigned long long waf = 0;
>> +       unsigned long long data_written_to_storage = 0;
>> +       unsigned long long data_written_by_user = 0;
>>   
>>          if (!sbi->iostat_enable)
>>                  return 0;
>>   
>> +       for (j = FS_DATA_IO; j <= FS_CP_META_IO; j++)
>
>FS_CDATA_IO is redundant?

I agree, and modified it.
		
>
>> +               data_written_to_storage += sbi->iostat_bytes[j];
>> +       for (j = FS_DATA_IO; j <= FS_CDATA_IO; j++)
>
>Just needs to include APP_WRITE_IO and APP_MAPPED_IO?

There is a slight time interval between requests in the form of APP_*_IO until they become requests in the form of FS_*_IO. On the other hand, we get the amount of file system meta data from FS_*_IO for 'data_written_to_storage'. So, If we use APP_*_IO for 'data_written_by_user', the 'waf' value returned during this time interval might have some difference from the actual value.

>
>Thanks,
>
>> +               data_written_by_user += sbi->iostat_bytes[j];
>> +
>> +       if (data_written_by_user > 0)
>> +               waf = data_written_to_storage * 100 / data_written_by_user;
>> +
>>          seq_printf(seq, "time:          %-16llu\n>", ktime_get_real_seconds());
>>          seq_printf(seq, "\t\t\t%-16s %-16s %-16s\n>",
>>                                  "io_bytes", "count", "avg_bytes");
>> @@ -81,6 +93,10 @@ int __maybe_unused iostat_info_seq_show(struct seq_file *seq, void *offset)
>>          IOSTAT_INFO_SHOW("fs discard", FS_DISCARD_IO);
>>          IOSTAT_INFO_SHOW("fs flush", FS_FLUSH_IO);
>>   
>> +       /* print waf */
>> +       seq_puts(seq, "[WAF]\n>");
>> +       seq_printf(seq, "fs waf:                %llu.%02llu\n>", waf / 100, waf % 100);
>> +
>>          return 0;
>>   }
>> 
