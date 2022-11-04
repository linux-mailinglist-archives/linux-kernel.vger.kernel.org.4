Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF186195ED
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiKDMK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiKDMKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:10:14 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC942D1F9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 05:10:13 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BCA335C008C;
        Fri,  4 Nov 2022 08:10:10 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Fri, 04 Nov 2022 08:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1667563810; x=1667650210; bh=+3
        H8CB5/oNHvAN43qyAMT/r+mH/dru8ma2r/u1N3f58=; b=ZG9EfUpw2g4jGXjve/
        vy1f4qdM8qUrv1VxKoe0oVezqCFcmq05hcy2hZ2ohyaAB7bXovKMVinfw1xWG/cw
        r35ak/vFIb9LlxL8RMd4U2X7LVPDKInScp67i9nnJc70NTZ/PZ8xi6crY6b3nHzH
        9VgYefd9KBOF4sUm7+59YTgZrzBqc2cRrakSC1IHqszQbsbOwOLW3lwu8EXYIFjB
        D8Iq6VQDTGNvt/aNRJvgfZoClJG21tiD+OeI+xNdA//9F2FkziipwM+ENsg7XiES
        sIZKi3pYKsmiK2+yuPYU1XKk3m1FL5anEOVtFD9oR8VVPQDM+BzB8Grj54WAzjDB
        5laA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667563810; x=1667650210; bh=+3H8CB5/oNHvAN43qyAMT/r+mH/d
        ru8ma2r/u1N3f58=; b=VurGaKbDx7cap4xf5/hZbhD0tZEJQw00/bqsPAUJSepz
        Np9NBEsMEpNMnwY5GVkfPCrvtDRNP6VnaCVoqBcGnaygLf3XAg06ce1DviWHBwzI
        opkTM2VFsKd/L/gyARXsuj/eyFKrd8SEuAPkklzgOnt6Z6ITnIyDl0JEY9KIEPex
        z6p8MHLd74cctO5nG//lmdXH9v+17J0u/3lY+UXk5KR6fHoPmsbmbgvR5D+UqjIf
        XHKyXs9TsSPrbctKBk4a3+ARWMcWMV5YTiunCfRLBeAssnu3LGKO4qOnYUOa/PxX
        tWk2VGaCtlu2HgiCXb8viR8QVFBvxPcbW/DxDqjtwg==
X-ME-Sender: <xms:IQFlY31BxDaWmOI4IyzOpl2N4qgdJkWcXRPOeEZOm0E3qw6OSvaS4g>
    <xme:IQFlY2FMmLGmnnl33p9vI_iX6QGS7NePuTphS8nEy0MPeFp3Oegu1xRmLGvUylgBZ
    K426KE65IEW4TpCez0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvddugdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefghfei
    veeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:IQFlY34DRPEplrfr5OjHznrQItpnw7yMMJB6L62w0mGeGVkuK6sq9w>
    <xmx:IQFlY80cJJbgYjdZCs6_nhY4jxod9hnon9njwHuJIYOsGdRxH6T0AQ>
    <xmx:IQFlY6E1gO5wdKjLknWEl-e-R_CfRUi0oNXnnyNA_Owl7LxvJG7DNw>
    <xmx:IgFlY2D60Z_2c7cSK6aGGY1O6qd262IzYtBUdi8JspSDdmOsLZcQyA>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CC854A6007C; Fri,  4 Nov 2022 08:10:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <9690ec57-4d7e-4a36-8ae3-953de05d3613@app.fastmail.com>
In-Reply-To: <26ce1ec2-effc-435f-8349-a12667973d92@app.fastmail.com>
References: <202211041544.R0jV58vk-lkp@intel.com>
 <26ce1ec2-effc-435f-8349-a12667973d92@app.fastmail.com>
Date:   Fri, 04 Nov 2022 13:09:49 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Arnd Bergmann" <arnd@arndb.de>,
        "kernel test robot" <lkp@intel.com>
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Hector Martin" <marcan@marcan.st>
Subject: Re: drivers/soc/apple/sart.c:190:38: warning: cast from 'void (*)(struct
 device *)' to 'void (*)(void *)' converts to incompatible function type
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022, at 09:14, Arnd Bergmann wrote:
> On Fri, Nov 4, 2022, at 09:01, kernel test robot wrote:
>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>
> Thanks for the report!
>
>>>> drivers/soc/apple/sart.c:190:38: warning: cast from 'void (*)(struct device *)' to 'void (*)(void *)' converts to incompatible function type [-Wcast-function-type-strict]
>>
>>            ret = devm_add_action_or_reset(dev, (void (*)(void *))put_device,
>>                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Sven, can you send a patch to add the missing helper function that calls
> put_device?

Sure, I'll send a patch tonight.


Sven
