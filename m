Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91741612710
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 04:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiJ3DRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 23:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJ3DRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 23:17:14 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 717AB1F2D6;
        Sat, 29 Oct 2022 20:17:12 -0700 (PDT)
Received: by ajax-webmail-mail-app2 (Coremail) ; Sun, 30 Oct 2022 11:17:01
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.32.139]
Date:   Sun, 30 Oct 2022 11:17:01 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jinlong Chen" <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc:     bvanassche@acm.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 0/3] queue freezing improvement and cleanups
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <cover.1667098953.git.nickyc975@zju.edu.cn>
References: <cover.1667098953.git.nickyc975@zju.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <79bc5c7e.1598db.18426e48610.Coremail.nickyc975@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgCHSrCt7F1jDA9LBw--.12310W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgUTB1ZdtcKOnAAEs5
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

SGkhCgpUaGUgaW1wcm92ZW1lbnRzIG9mIHRoZSBkZXNjcmlwdGlvbnMgYXJlIHN1Z2dlc3RlZCBi
eSBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVAYWNtLm9yZz4uIFNvcnJ5IGZvciB0aGUgbWlz
c2luZy4KClRoYW5rcyEKSmlubG9uZyBDaGVuCg==
