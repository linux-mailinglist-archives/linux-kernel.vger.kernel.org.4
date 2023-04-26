Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23656EF919
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbjDZROo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbjDZROj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:14:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3670446A1;
        Wed, 26 Apr 2023 10:14:38 -0700 (PDT)
Received: from [100.127.1.155] (unknown [152.37.90.84])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dwlsalmeida)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B4B756600864;
        Wed, 26 Apr 2023 18:14:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682529275;
        bh=Dcun5oNCOCFo7L673tpG/HZq/i2cDaSzyIlQU9SgMeU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m+0l8j60/rL8i+QHt9zvW3X7PTAwK9B9JjmdoyeXnZJvptHrrNg9QUrqFrYzWlXSJ
         66KchxA+NrA82qxYe3V+zqsB1m5eK47yXBOLedEzh7JR7BPAgqiRHESV08Al/cbM5N
         6QatVh8IvgfqpIPX4xIPiThG6tYRWvy4nHRotXzk+puZAGlumj08tRGPxuY1/f/QDb
         cEx1AL9UduYPVttQ4hxd6/atvogoOQmr9X9W0Ebpfg0P1qk1QLayFvWSsNYZ+72mh2
         l/0CItHpL4SZrNfBgIt7VOeAdpFRjDw7KyIZQ0qqP7XYKcE+2H5Gg+7kVPym+Xc5qa
         3uoD/oODmDjeQ==
Message-ID: <7b4ea4fc-7d73-d229-4645-366b1ea574fb@collabora.com>
Date:   Wed, 26 Apr 2023 18:14:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, wedsonaf@gmail.com,
        ojeda@kernel.org, mchehab@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com,
        Sakari Ailus <sakari.ailus@iki.fi>
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl>
 <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
 <20230426003210.GA31260@pendragon.ideasonboard.com>
 <CANiq72nLtpOn2HcOneoQ6v_TcYAEj_W8z2HCQvF4HmB4+OoSZA@mail.gmail.com>
 <20230426163512.GE18120@pendragon.ideasonboard.com>
From:   Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20230426163512.GE18120@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As I said higher up on this thread, I can maintain the Rust bits and 
help out with the issues around it.

IMHO, we should at least try this. Who knows, it might work out :)

Laurent, maybe we can take a piecemeal approach? Right now there are no 
bindings for MC, but I wouldn't complain about fixing some of the C code 
when the time comes.

Just FYI, I am writing some more bindings, just enough to write a 
stateless decoder driver. I hope to finish it in time for the media 
summit. It will give us a more in-depth idea of the pros and cons here.

-- Daniel
