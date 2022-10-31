Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC72613759
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiJaNFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiJaNFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:05:41 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D670B2632;
        Mon, 31 Oct 2022 06:05:38 -0700 (PDT)
Received: by ajax-webmail-mail-app2 (Coremail) ; Mon, 31 Oct 2022 21:05:15
 +0800 (GMT+08:00)
X-Originating-IP: [10.14.30.50]
Date:   Mon, 31 Oct 2022 21:05:15 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jinlong Chen" <nickyc975@zju.edu.cn>
To:     "kernel test robot" <yujie.liu@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@kernel.dk, kbusch@kernel.org,
        hch@lst.de, sagi@grimberg.me, bvanassche@acm.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [RESEND PATCH v2 3/3] block: hide back
 blk_freeze_queue_start and export its blk-mq alias
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <202210311456.2d2c7899-yujie.liu@intel.com>
References: <202210311456.2d2c7899-yujie.liu@intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <e316420.15e91d.1842e256c7e.Coremail.nickyc975@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgCHz1sLyF9jH0BTBw--.53074W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgIAB1ZdtcLuXwAAsK
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW5Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pgo+IEdyZWV0aW5nLAo+IAo+IEZZSSwgd2Ugbm90aWNlZCBXQVJOSU5HOmF0X2Jsb2NrL2Jsay1t
cS5jOiNibGtfbXFfZnJlZXplX3F1ZXVlIGR1ZSB0byBjb21taXQgKGJ1aWx0IHdpdGggZ2NjLTEx
KToKPgoKU29ycnkgZm9yIHRoZSBkaXN0dXJiYW5jZS4KClRoZSBwYXRjaCBzZXJpZXMgaXMgZGVw
cmVjYXRlZC4gUGxlYXNlIGlnbm9yZSB0aGlzLgoKVGhhbmtzIQpKaW5sb25nIENoZW4=
