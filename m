Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B328605AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiJTJLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJTJLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:11:50 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B4A18DA86
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 02:11:48 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-191-ZMBlQfPROP-jbXzqifNJWw-1; Thu, 20 Oct 2022 10:11:30 +0100
X-MC-Unique: ZMBlQfPROP-jbXzqifNJWw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 20 Oct
 2022 10:11:26 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Thu, 20 Oct 2022 10:11:26 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Amit' <amitchoudhary0523@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Generic Linked List Library (like C++ STL list) - version 1.0
Thread-Topic: Generic Linked List Library (like C++ STL list) - version 1.0
Thread-Index: AQHY5E7OgI5CeaD6zU+U2dkFrDyM5a4W/w4Q
Date:   Thu, 20 Oct 2022 09:11:26 +0000
Message-ID: <68e638dbc7f246e39f30a5d5681ee76e@AcuMS.aculab.com>
References: <CAFf+5zhr96ORRJO_AMn3ZVc-REdkYAjxegq-3p=LSnGybgpG6g@mail.gmail.com>
In-Reply-To: <CAFf+5zhr96ORRJO_AMn3ZVc-REdkYAjxegq-3p=LSnGybgpG6g@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW1pdA0KPiBTZW50OiAyMCBPY3RvYmVyIDIwMjIgMDc6NDANCj4gDQo+IEdlbmVyaWMg
TGlua2VkIExpc3QgTGlicmFyeSAobGlrZSBDKysgU1RMIGxpc3QpIC0gdmVyc2lvbiAxLjANCj4g
DQo+IFRoZSBjb2RlIGlzIGJlbG93Og0KDQpNb3ZlIGFsbCBjb3BpZXMgb2YgaXQgdG8gL2Rldi9u
dWxsLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0K

