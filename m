Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7465715926
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjE3I4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjE3I4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:56:14 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 May 2023 01:56:11 PDT
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C964BE
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:56:11 -0700 (PDT)
X-KPN-MessageId: 9150d9a8-fec7-11ed-8f97-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 9150d9a8-fec7-11ed-8f97-00505699b430;
        Tue, 30 May 2023 10:54:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=KeYfZ06rkafUiVhvXtxz1pIwLEUIQSPMvMXjwuaAdO4=;
        b=OTDSVptP7bURCu/c9/MO7WlVKtsozou2PYwG/xqDxaD9mHR/MCMOY3dI2E8UEWiAByhAp7lqNa4Hz
         GpgfJwKxDnylluy7KvkZKeeIl+M1gfX2qCBdnqES/yI2rscYZTbOMBoNPnZftc1CCMPXeCgOIZQ+DX
         i+NdKZ8I3lpYRx18nLPKUEMqg1MMQ6VPTqq/x9/GRiPXaaPASejjtguzxCh9xLL5mhHo8tsdIIUVn7
         uZTFOCcnvSe9hsV6Lb83yM30yGNcb/uWsG3yflyd1lkk986VM6MusZPfUVh2cCaBUXX6a+8E+hSKl+
         rA9mVeHf15vX+IAlzfk6zwledYDWuWQ==
X-KPN-MID: 33|K8osm6JgAOUfS6Vhr6RM0H7GmHZ3TLYp4rWWtMKd0rZJoG0wyjDFfrq9TQfMQ9w
 Jv59UUX5O9QLMt/8q0ww9obiPjAAM8VWyNg8uc0xs+LA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|p2PpW6AUl/WMPvVuOaO18EeHiiFN/Y7IFIwjJs98B1OIx+NllflOnemJVXB/lev
 4jwaHQ2XV52tJC94Kdckuwg==
X-Originating-IP: 173.38.220.44
Received: from [10.47.77.214] (unknown [173.38.220.44])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id a98dfdd8-fec7-11ed-b306-00505699d6e5;
        Tue, 30 May 2023 10:55:03 +0200 (CEST)
Message-ID: <849d601d-9504-7118-0c99-a9bc3bb040eb@xs4all.nl>
Date:   Tue, 30 May 2023 10:55:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5,0/8] media: mediatek: vcodec: Add debugfs file for
 decode and encode
Content-Language: en-US
To:     =?UTF-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "nhebert@chromium.org" <nhebert@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
References: <20230525021219.23638-1-yunfei.dong@mediatek.com>
 <ec8c0113aff833aa7de746843e8e4b4294b7ea8e.camel@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <ec8c0113aff833aa7de746843e8e4b4294b7ea8e.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 10:27, Yunfei Dong (董云飞) wrote:
> Hi Hans,
> 
> Sorry to disturb you.
> 
> Could you please help to review and apply this patch series if it is ok
> for you? Or whose review is expected before you can apply?

AngeloGioacchino Del Regno reviewed this series before, so I'd like to
have his OK for this series.

Regards,

	Hans

> 
> Best Regards,
> Yunfei Dong
> 
> On Thu, 2023-05-25 at 10:12 +0800, Yunfei Dong wrote:
>> Need to change kernel driver to open decode and encode debug log at
>> current period,
>> it's very unreasonable. Adding debugfs common interface to support
>> decode and encode,
>> using echo command to control debug log level and getting useful
>> information for each
>> instance.
>>
>> patch 1 add dbgfs common interface.
>> patch 2~5 support decode.
>> patch 6~7 support encode
>> patch 8 add help function
>> ---
>> changed with v4:
>> - rebase to the top of media stage header.
>>
>> changed with v3:
>> - add help function for patch 8
>> - remove append '\0' and enlarge buffer size for patch 4
>>
>> changed with v2:
>> - using pr_debug and dev_dbg instead of pr_info for patch 2.
>> - fix word fail: informatiaoin -> information for patch 3.
>> - used to print each instance format information for patch 5.
>>
>> changed with v1:
>> - add new patch 4 and 5.
>> - using cmd 'cat vdec' to show debug information instead of pr_info
>> directly.
>> ---
>> Yunfei Dong (8):
>>   media: mediatek: vcodec: Add debugfs interface to get debug
>>     information
>>   media: mediatek: vcodec: Add debug params to control different log
>>     level
>>   media: mediatek: vcodec: Add a debugfs file to get different useful
>>     information
>>   media: mediatek: vcodec: Get each context resolution information
>>   media: mediatek: vcodec: Get each instance format type
>>   media: mediatek: vcodec: Change dbgfs interface to support encode
>>   media: mediatek: vcodec: Add encode to support dbgfs
>>   media: mediatek: vcodec: Add dbgfs help function
>>
>>  .../media/platform/mediatek/vcodec/Makefile   |   6 +
>>  .../mediatek/vcodec/mtk_vcodec_dbgfs.c        | 216
>> ++++++++++++++++++
>>  .../mediatek/vcodec/mtk_vcodec_dbgfs.h        |  72 ++++++
>>  .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |   4 +
>>  .../platform/mediatek/vcodec/mtk_vcodec_drv.h |   4 +
>>  .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |   2 +
>>  .../mediatek/vcodec/mtk_vcodec_util.c         |   8 +
>>  .../mediatek/vcodec/mtk_vcodec_util.h         |  26 ++-
>>  8 files changed, 335 insertions(+), 3 deletions(-)
>>  create mode 100644
>> drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
>>  create mode 100644
>> drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
>>

