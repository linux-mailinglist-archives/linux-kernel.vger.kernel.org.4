Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9BB635622
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbiKWJYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237635AbiKWJYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:24:10 -0500
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01971032
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:22:41 -0800 (PST)
X-QQ-GoodBg: 2
X-QQ-SSF: 0040000000B00050
X-QQ-FEAT: gteAknHNoYKQOJ++3tdxfYsLngky6VNps3zHcNE6bJ8yeIjgpog3dejQngndP
        q3Lm4GuOGkCkiZTtJYNYPLlTzIgFdhwJaWuFBXpt9zr/eqlXZgBmm6jjl10cDNKpcOAIw/y
        Sgau9YA2FNfzfnbMJWu8BlOz1eaIJ4rL4k3YIVjymIH/8O9KFBLv4eDxGFiw0K4O28gmfJp
        MGUnLaufc58SJ8+UL140gtalY+8C/tRJY/1XZ39gbFJlpxmMyNN6Qx2w1K/27HlOT+2VBIU
        NlfuKS8Z6m9vm+oUPx/Rq57hlimrcMv/wOYbfDceKgW1ClDZC7NMF4yrUgdj6ySuBfKGETX
        BqFHGiZHt8fwudlgy+aqqH3H/IXuDk0x3o8bDaVNyk+4uImDxL+H2mi2IE8qA==
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 223.72.214.84
X-QQ-STYLE: 
X-QQ-mid: maileng8t1669195266t197957
From:   "=?utf-8?B?546L5rSq6L6J?=" <honghui.wang@ucas.com.cn>
To:     "=?utf-8?B?UGV0ciBNbGFkZWs=?=" <pmladek@suse.com>
Cc:     "=?utf-8?B?U2VyZ2V5IFNlbm96aGF0c2t5?=" <senozhatsky@chromium.org>,
        "=?utf-8?B?U3RldmVuIFJvc3RlZHQ=?=" <rostedt@goodmis.org>,
        "=?utf-8?B?Sm9obiBPZ25lc3M=?=" <john.ogness@linutronix.de>,
        "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] printk: fix a typo of comment
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Wed, 23 Nov 2022 17:21:05 +0800
X-Priority: 3
Message-ID: <tencent_58021F77224429481C4676D4@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <0C7C980DB815FAE1+Y3yNXJCqZ3Nzxa5V@TP-P15V.lan>
        <Y3yvmMq8FsK85qjl@alley>
In-Reply-To: <Y3yvmMq8FsK85qjl@alley>
X-QQ-ReplyHash: 312409942
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Wed, 23 Nov 2022 17:21:07 +0800 (CST)
Feedback-ID: maileng:ucas.com.cn:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_NONE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzLEJlc3QgUmVnYXJkcyFXYW5nIEhvbmdodWkmbmJzcDsmbmJzcDstLS0tLS0tLS0t
LS0tLS0tLS0mbmJzcDtPcmlnaW5hbCZuYnNwOy0tLS0tLS0tLS0tLS0tLS0tLUZyb206ICZu
YnNwOyJQZXRyJm5ic3A7TWxhZGVrIjxwbWxhZGVrQHN1c2UuY29tPjtEYXRlOiAmbmJzcDtU
dWUsIE5vdiAyMiwgMjAyMiAwNzoxNiBQTVRvOiAmbmJzcDsiV2FuZyBIb25naHVpIjxob25n
aHVpLndhbmdAdWNhcy5jb20uY24+OyBDYzogJm5ic3A7IlNlcmdleSBTZW5vemhhdHNreSI8
c2Vub3poYXRza3lAY2hyb21pdW0ub3JnPjsgIlN0ZXZlbiBSb3N0ZWR0Ijxyb3N0ZWR0QGdv
b2RtaXMub3JnPjsgIkpvaG4gT2duZXNzIjxqb2huLm9nbmVzc0BsaW51dHJvbml4LmRlPjsg
ImxpbnV4LWtlcm5lbCI8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IFN1YmplY3Q6
ICZuYnNwO1JlOiBbUEFUQ0ggVjJdIHByaW50azogZml4IGEgdHlwbyBvZiBjb21tZW50Jm5i
c3A7T24gVHVlIDIwMjItMTEtMjIgMTY6NTA6MzYsIFdhbmcgSG9uZ2h1aSB3cm90ZTomZ3Q7
IEZpeCBhIHR5cG8gb2YgY29tbWVudCZndDsgJmd0OyBTaWduZWQtb2ZmLWJ5OiBXYW5nIEhv
bmdodWkgPGhvbmdodWkud2FuZ0B1Y2FzLmNvbS5jbj5KRllJLCB0aGUgcGF0Y2ggaGFzIGJl
ZW4gY29tbWl0dGVkIGludG8gcHJpbnRrL2xpbnV4LmdpdCwgYnJhbmNoIGZvci02LjIuQmVz
dCBSZWdhcmRzLFBldHJQUzogSSBoYXZlIGFkZGVkIEpvaG4ncyBSZXZpZXdlZC1ieSBmcm9t
IHYxIFsxXS4gVGhpcyB2ZXJzaW9uIG9mIHRoZSBwYXRjaCBqdXN0IGZpeGVkIHRoZSB0eXBv
IHRoYXQgSm9obiBtZW50aW9uZWQgdGhlcmVbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
ci84NzRqdXJxdDVnLmZzZkBqb2duZXNzLmxpbnV0cm9uaXguZGU8L2hvbmdodWkud2FuZ0B1
Y2FzLmNvbS5jbj48L2xpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+PC9qb2huLm9nbmVz
c0BsaW51dHJvbml4LmRlPjwvcm9zdGVkdEBnb29kbWlzLm9yZz48L3Nlbm96aGF0c2t5QGNo
cm9taXVtLm9yZz48L2hvbmdodWkud2FuZ0B1Y2FzLmNvbS5jbj48L3BtbGFkZWtAc3VzZS5j
b20+

