Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D253604D61
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJSQ1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiJSQ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:27:43 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC7121C810D;
        Wed, 19 Oct 2022 09:27:40 -0700 (PDT)
Received: by ajax-webmail-mail-app4 (Coremail) ; Thu, 20 Oct 2022 00:27:37
 +0800 (GMT+08:00)
X-Originating-IP: [10.181.230.190]
Date:   Thu, 20 Oct 2022 00:27:37 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   22021009@zju.edu.cn
To:     "Christoph Hellwig" <hch@infradead.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] blk-mq, elevator: pair up elevator_get and
 elevator_put to avoid refcnt problems
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <Y1ASCGVJ1SJY7fi3@infradead.org>
References: <20221019132053.3597239-1-nickyc975@zju.edu.cn>
 <Y1ASCGVJ1SJY7fi3@infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <d2ea597.1361e8.183f1126223.Coremail.22021009@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgDn7095JVBj0wtlBw--.38836W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgEIB1ZdtcAClAABsl
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkkgdGhpbmsgdGhpcyBsb29rcyByZWFzb25hYmxlLCBidXQgcmVhbGx5IG5lZWRzIHRvIGJlIHNw
bGl0IHVwIGludG8KPmEgZmV3IHNlbGYtY29udGFpbmVkIHBhdGNoZXMuICBJJ3ZlIHN0YXJ0ZWQg
bG9va2luZyBpbnRvIHRoYXQsIGdpdmUKPm1lIGEgYml0IG9mIHRpbWUgdG8gc2VuZCBpdCB0b2dl
dGhlciB3aXRoIHNvbWUgZXh0cmEgY2xlYW51cHMuICBJJ2xsCj5tYWtlIHN1cmUgdG8gcHJlc2Vy
dmUgeW91ciBhdHRyaWJ1dGlvbi4KClRoYW5rcywgQ2hyaXN0b3BoIQoKSSBhbSBuZXcgdG8ga2Vy
bmVsIGRldmVsb3BtZW50LiBUaGVyZSBpcyBkZWZpbml0ZWx5IGEgYnVuY2ggb2YgdGhpbmdzIEkg
bmVlZCB0byBsZWFybi4gOikKCkppbmxvbmcgQ2hlbg==
