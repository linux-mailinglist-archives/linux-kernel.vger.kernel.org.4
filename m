Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29BE5F8628
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 19:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiJHRIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 13:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJHRIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 13:08:06 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BDF3BC56;
        Sat,  8 Oct 2022 10:08:05 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.18]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MgNpJ-1pOFgQ41uh-00hucE; Sat, 08 Oct 2022 19:07:26 +0200
Message-ID: <bce9efac-15a8-75e5-6f3f-bc62e33d0184@i2se.com>
Date:   Sat, 8 Oct 2022 19:07:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] clk: bcm: rpi: Fix an out-of-bound access to
 raspberrypi_clk_variants
To:     Xu Kuohai <xukuohai@huaweicloud.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Xu Kuohai <xukuohai@huawei.com>
References: <20221008144544.283945-1-xukuohai@huaweicloud.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20221008144544.283945-1-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:AZmXji+Ie9jYHOzIlgRs0gDX/oNVksZ7yKBebF95ZMrkMz8LTTw
 Hy9D2+qykIRrldaHtJy4bV990ESxz3bpUi36so0Fh8jzYGAtQnqKQZu8W62Of3j4ZaKBieV
 DJ4fVy1baJLERCQTxXL5lYi8pry+dUUywkbPjDrs/q7SPYMK2mIEuTSRCFqBerKWC1/jyR+
 ECGHfxuEsXwRKi3wXPq+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:19cskiiydFc=:6tsc4x3Utxa7k8gtI3IAd6
 wNgLrQIpDTY5nr2vfR7PrggjpagVpdjqcpTUzLL81bdhB9HjqZsxxeSoi5dIe42fOWWyRVIbM
 UwehcSqpngKNRAaP9dAWzzStkw3TouTK2dOw08nfwHX2EiQ/nLt0hTVTguKssPhT1dY+qjp9F
 PFfcmz0cwOcvJa2+doA6rO2X7/Oz8lE9wol04DdydEw++QRLh+DQJqYyhQCtdGF3sEvKNGsrh
 tS/tJJoy+uWT6e9D7hf4wvcuqlryelRI9mOANsj5XLXHqK2M1XdMu6XeE7wL2XsrK+6gjmc9q
 FA+rD5xA2RGVW+PhInygZYWKmq11LG3Q3X+fKHIM510PfX3A9ZkiLD3zy9KAf2ji4SnN43OaX
 Q9pzjfqCOibGLvSg4Aj7eq1LZatvztu5i70u9jA6hvoVykPPi7+k9iZlnZzXMcjb0GPBwYPiD
 4DLZF7mGkmiRqTd8ehLPrjNI2e7wqwDKM02bvwUAOGhYu1d6P4mVXFtDHETO4PzNT+MKT6A9M
 4XPhEE/QDFNLUZty/m4hqo1gj0VAjxZUc3yxawx5N3skARebYJuwBdaM3Fh9GLLwqb36pJ5Nx
 fHhAYjPLqGYstTJfcglSRhJjVx7l0ShHfQ2LPXtmNuNjzJPVuWhfjDM7AjaHTGuRcmsl/LPqU
 V+Sq/Xo4DuSXk+G5LQUAUHOQbNK5GhhDAfTd9GpuDa8Z9Ca0I2xrgVA5DItx0KTH+Mhd1UUNb
 upFU2MzxRlKChR9a3h6uywEm+3UJwpp20bp4tEkNYCZ0Y9m6wxRR3GVDHgWZMKyazNK9jyoac
 Y2Xqw7MPvs4ATNDES0N2meqhj8VBg==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xu,

Am 08.10.22 um 16:45 schrieb Xu Kuohai:
> From: Xu Kuohai <xukuohai@huawei.com>
>
> KASAN reports an out-of-bound access to raspberrypi_clk_variants[]:
>
> ==================================================================
> BUG: KASAN: global-out-of-bounds in raspberrypi_clk_probe+0x1dc/0x690
> Read of size 1 at addr ffffcc7116d615a0 by task kworker/u8:0/8
>
> CPU: 1 PID: 8 Comm: kworker/u8:0 Not tainted 6.0.0-rc3-00900-g08f4df4a3c53 raspberrypi#10

this kernel is a little bit older and doesn't contain bc163555603e 
("clk: bcm: rpi: Prevent out-of-bounds access").

Can you please check Linux 6.0?

Best regards

