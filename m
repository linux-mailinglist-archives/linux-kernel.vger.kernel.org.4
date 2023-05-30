Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EF0715BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjE3KdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjE3KdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:33:17 -0400
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B48493
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:33:14 -0700 (PDT)
X-KPN-MessageId: 61661a09-fed5-11ed-ac2e-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 61661a09-fed5-11ed-ac2e-005056994fde;
        Tue, 30 May 2023 12:33:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=dhncDJHXANDQNkfS842Kl2cY/c46thjSz6u0YRShRlI=;
        b=hWRRqJ6DH+lM/gLJocbXs+ntdE8QsfhQkBUthUzlo0N0MulXGN3MS7Qf8L54H1Ra4VraOe/cavATc
         qUc6UcCGFMPFLoZQPNV1IWQ6niEjTKt8nsBs5A/DIiyFerqc1l1/hK9lH6/lSCCPnF85tUozWga3F4
         4C2LppTrzamcJdFXxMNjTegrqNjNqQXXPczff542HLbg0Lt2OCwOWGLQaEmTpnf6FdAKguhxGn2a3/
         S5yv3esp7UlRCucEljDGuCPFevlhmc88HchD+SZJ0P6vJjh0EYC+sjDiPIsnrDFOAtY0Qw1lL56WvP
         upZmguP/MzDEhOZDV9B6d5gD02WmwuA==
X-KPN-MID: 33|2k5QJyYR4/t2fa9CzV1waT0MUhBFGBHIoKQn6RbdcKK+6mGoFeKy8NC6LxqDLuh
 bQ7dMBf67oZT4HbZHH2PWkbsvv8/uYo+PRjqlHOjDsZU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|qIwiHluoQX0nsW+Oi14G3QE1ZFn6v55r8PvRMvAIkDtKqqbFnwZ+zveHsoiNDtT
 ae2LsXDlJRkVo2EDC9xunog==
X-Originating-IP: 173.38.220.44
Received: from [10.47.77.214] (unknown [173.38.220.44])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 6037fa81-fed5-11ed-b306-00505699d6e5;
        Tue, 30 May 2023 12:33:12 +0200 (CEST)
Message-ID: <da165529-ae9a-8461-c582-9c85e6f2fa4c@xs4all.nl>
Date:   Tue, 30 May 2023 12:33:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5,8/8] media: mediatek: vcodec: Add dbgfs help function
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, Nathan Hebert <nhebert@chromium.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230525021219.23638-1-yunfei.dong@mediatek.com>
 <20230525021219.23638-9-yunfei.dong@mediatek.com>
 <f3322e41-1891-a33b-daaa-731ec548ec4e@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <f3322e41-1891-a33b-daaa-731ec548ec4e@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 12:06, AngeloGioacchino Del Regno wrote:
> Il 25/05/23 04:12, Yunfei Dong ha scritto:
>> Getting dbgfs help information with command "echo -help > vdec".
>>
>> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
>> ---
>>   .../mediatek/vcodec/mtk_vcodec_dbgfs.c        | 24 ++++++++++++++++++-
>>   1 file changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
>> index 237d0dc8a1fc..2372fc449b45 100644
>> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
>> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
>> @@ -52,6 +52,23 @@ static void mtk_vdec_dbgfs_get_format_type(struct mtk_vcodec_ctx *ctx, char *buf
>>   	*used += curr_len;
>>   }
>>   
>> +static void mtk_vdec_dbgfs_get_help(char *buf, int *used, int total)
>> +{
>> +	int curr_len;
>> +
>> +	curr_len = snprintf(buf + *used, total - *used,
>> +			    "help: (1: echo -'info' > vdec 2: cat vdec)\n");
>> +	*used += curr_len;
>> +
>> +	curr_len = snprintf(buf + *used, total - *used,
>> +			    "\t-picinfo: get resolution\n");
>> +	*used += curr_len;
>> +
>> +	curr_len = snprintf(buf + *used, total - *used,
>> +			    "\t-format: get output & capture queue format\n");
>> +	*used += curr_len;
>> +}
>> +
>>   static ssize_t mtk_vdec_dbgfs_write(struct file *filp, const char __user *ubuf,
>>   				    size_t count, loff_t *ppos)
>>   {
>> @@ -84,6 +101,11 @@ static ssize_t mtk_vdec_dbgfs_read(struct file *filp, char __user *ubuf,
>>   	if (!buf)
>>   		return -ENOMEM;
>>   
>> +	if (strstr(dbgfs->dbgfs_buf, "-help")) {
> 
> I would print the help strings in two conditions:
> 1. -help
> 2. (nothing)
> 
> ...so that if you don't echo anything to vdec (no params), you get the help text.
> Otherwise, you would have to know that "-help" is a parameter that gives you help
> text in the first place.
> 
> As for this commit "as is", it works as intended and it is useful to retrieve
> the help text; you can either send a followup commit that extends the help to
> the corner case that I've explained, or send a v6 adding that to this same commit.
> 
> I would prefer to see a v6 -- BUT -- since this series was sent a long time ago,
> you will get my R-b and I will leave the final choice to Hans.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> 

I prefer a v6, rebased on top of the media_stage tree.

Regards,

	Hans
