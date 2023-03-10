Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781FD6B4E15
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjCJRJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjCJRHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:07:49 -0500
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE3B18B19;
        Fri, 10 Mar 2023 09:06:39 -0800 (PST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id BB9393A2B24;
        Fri, 10 Mar 2023 18:06:34 +0100 (CET)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id A48383A2B18;
        Fri, 10 Mar 2023 18:06:34 +0100 (CET)
X-TM-AS-ERS: 10.181.10.103-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgxLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx1.dmz.swissbit.com (mx.dmz.swissbit.com [10.181.10.103])
        by mail5.swissbit.com (Postfix) with ESMTPS;
        Fri, 10 Mar 2023 18:06:34 +0100 (CET)
From:   =?utf-8?B?Q2hyaXN0aWFuIEzDtmhsZQ==?= <CLoehle@hyperstone.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Wenchao Chen <wenchao.chen666@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
Thread-Topic: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
Thread-Index: AQHZTRVhGw7IamWdbkW+N3YLAv3UBK70EaAwgAADtICAACp0AA==
Date:   Fri, 10 Mar 2023 17:06:32 +0000
Message-ID: <4a2c5b752968496ca72966f80e148d47@hyperstone.com>
References: <20230302144330.274947-1-ulf.hansson@linaro.org>
 <54cee7de4ab7479db74b21e64e5f53cf@hyperstone.com>
 <CAPDyKFq-qToEX+qiuHirNbcuedii_f0KKuHiPAv7+tydrUTpqQ@mail.gmail.com>
In-Reply-To: <CAPDyKFq-qToEX+qiuHirNbcuedii_f0KKuHiPAv7+tydrUTpqQ@mail.gmail.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27496.001
X-TMASE-Result: 10--32.656200-10.000000
X-TMASE-MatchedRID: UGkmQMDcUOnUL3YCMmnG4vHkpkyUphL9dwX/SSKrKHjKV5hCFWDUirX9
        hnMqzl+7X64KjR1hKzpMCgkc3/BmTYd/gi/Pxf7NPMcAlOC0qrDhx1VJT84rPRHfiujuTbedXH3
        W+57nGflI/gFRC4jJyCcntLVR9yI1xONdUAdRajMR3SGennXG69FBNyU0Q3FE7zyq0taM3pjxhu
        T2TM8RaFGyxACqIZ7HSH8ogO2fTuw5rof3b4z0VKtK3oodxPaxsVwPMKjZm1ZcZUa13Wf//3VXQ
        3/qdw5y8+PJOD6ybejCnfj2t9y5LAHth38hX4u2HFAJdqqxfclpeZ1cXZibx1DlkDrrCwNSuLOn
        20yiTmb4uMbkNFIz6Mqv4cKQcFXisK6XZdVVEg/P01G0ZRd+f5XdNEOUjtKuXfXw2EpveOVdvdj
        b5Iwdbstt6YaNEW8D4oYOs4DZ8uEzB98Fjsee54h/ebSxR/Hn37jcLTY9yERXPwnnY5XL5Jw6cu
        pP5YJ9PaFSMG/LkqMyNCoZMgfGS/tzqsXu3a66olVO7uyOCDUArX6cHuDjb5soi2XrUn/J+ZL5o
        +vRV7xKWdTfwsJjy2LHjeGkjh9X3QfwsVk0Ubv+efAnnZBiL6nKAIYoU8L4F5iXm5LZACA=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 15e7a894-2ef4-418f-8141-0474105ff189-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+Pg0KPj4gSSBoYXZlIGJlbmNobWFya2VkIHRoZSBGVUEvQ2FjaGUgYmVoYXZpb3IgYSBiaXQu
DQo+PiBJIGRvbid0IGhhdmUgYW4gYWN0dWFsIGZpbGVzeXN0ZW0gYmVuY2htYXJrIHRoYXQgZG9l
cyB3aGF0IEkgd2FudGVkIGFuZCBpcyBlYXN5IHRvIHBvcnQgdG8gdGhlIHRhcmdldCBzbyBJIHVz
ZWQ6DQo+Pg0KPj4gIyBjYWxsIHdpdGgNCj4+ICMgZm9yIGxvb3AgaW4gezEuLjN9OyBkbyBzdWRv
IGRkIGlmPS9kZXYvdXJhbmRvbSBicz0xTSANCj4+IG9mPS9kZXYvbW1jYmxrMjsgZG9uZTsgZm9y
IGxvb3AgaW4gezEuLjV9OyBkbyB0aW1lIA0KPj4gLi9maWxlc3lzdGVtYmVuY2htYXJrLnNoOyB1
bW91bnQgL21udDsgZG9uZQ0KPj4gbWtmcy5leHQ0IC1GIC9kZXYvbW1jYmxrMg0KPj4gbW91bnQg
L2Rldi9tbWNibGsyIC9tbnQNCj4+IGZvciBpIGluIHsxLi4zfQ0KPj4gZG8NCj4+IGNwIC1yIGxp
bnV4LTYuMi4yIC9tbnQvJGkNCj4+IGRvbmUNCj4+IGZvciBpIGluIHsxLi4zfQ0KPj4gZG8NCj4+
IHJtIC1yIC9tbnQvJGkNCj4+IGRvbmUNCj4+IGZvciBpIGluIHsxLi4zfQ0KPj4gZG8NCj4+IGNw
IC1yIGxpbnV4LTYuMi4yIC9tbnQvJGkNCj4+IGRvbmUNCj4+DQo+Pg0KPj4gSSBmb3VuZCBhIGNv
dXBsZSBvZiBEVVRzIHRoYXQgSSBjYW4gbGluaywgSSBhbHNvIHRlc3RlZCBvbmUgaW5kdXN0cmlh
bCBjYXJkLg0KPj4NCj4+IERVVDE6IGJsdWUgUENCIEZvcmVzZWUgZU1NQw0KPj4gaHR0cHM6Ly9w
aW5lNjQuY29tL3Byb2R1Y3QvMzJnYi1lbW1jLW1vZHVsZS8NCj4+IERVVDI6IGdyZWVuIFBDQiBT
aWxpY29uR28gZU1NQw0KPj4gQ291bGRuJ3QgZmluZCB0aGF0IG9uZSBvbmxpbmUgYW55bW9yZSB1
bmZvcnR1bmF0ZWx5DQo+PiBEVVQzOiBvcmFuZ2UgaGFyZGtlcm5lbCBQQ0IgOEdCDQo+PiBodHRw
czovL3d3dy5oYXJka2VybmVsLmNvbS9zaG9wLzhnYi1lbW1jLW1vZHVsZS1jMi1hbmRyb2lkLw0K
Pj4gRFVUNDogb3JhbmdlIGhhcmRrZXJuZWwgUENCIHdoaXRlIGRvdA0KPj4gaHR0cHM6Ly9ybHgu
c2svZW4vb2Ryb2lkLzMxOTgtMTZnYi1lbW1jLTUwLW1vZHVsZS14dTMtYW5kcm9pZC1mb3Itb2Ry
bw0KPj4gaWQteHUzLmh0bWwNCj4+IERVVDU6IEluZHVzdHJpYWwgY2FyZA0KPg0KPiBUaGFua3Mg
YSBsb3QgZm9yIGhlbHBpbmcgb3V0IHdpdGggdGVzdGluZyEgTXVjaCBhcHByZWNpYXRlZCENCg0K
Tm8gcHJvYmxlbSwgZ2xhZCB0byBiZSBvZiBoZWxwLg0KDQo+DQo+Pg0KPj4NCj4+IFRoZSB0ZXN0
IGlzc3VlZCA0NjEgRE9fUkVMX1dSIGR1cmluZyBvbmUgb2YgdGhlIGl0ZXJhdGlvbnMgZm9yIERV
VDUNCj4+DQo+PiBEVVQxOg0KPj4gQ2FjaGUsIG5vIEZVQToNCj4+IDEzOjA0LjQ5DQo+PiAxMzox
My44Mg0KPj4gMTM6MzAuNTkNCj4+IDEzOjI4OjEzDQo+PiAxMzoyMDo2NA0KPj4gRlVBOg0KPj4g
MTM6MzAuMzINCj4+IDEzOjM2LjI2DQo+PiAxMzoxMC44Ng0KPj4gMTM6MzIuNTINCj4+IDEzOjQ4
LjU5DQo+Pg0KPj4gRFVUMjoNCj4+IEZVQToNCj4+IDg6MTEuMjQNCj4+IDc6NDcuNzMNCj4+IDc6
NDguMDANCj4+IDc6NDguMTgNCj4+IDc6NDcuMzgNCj4+IENhY2hlLCBubyBGVUE6DQo+PiA4OjEw
LjMwDQo+PiA3OjQ4Ljk3DQo+PiA3OjQ4LjQ3DQo+PiA3OjQ3LjkzDQo+PiA3OjQ0LjE4DQo+Pg0K
Pj4gRFVUMzoNCj4+IENhY2hlLCBubyBGVUE6DQo+PiA3OjAyLjgyDQo+PiA2OjU4Ljk0DQo+PiA3
OjAzLjIwDQo+PiA3OjAwLjI3DQo+PiA3OjAwLjg4DQo+PiBGVUE6DQo+PiA3OjA1LjQzDQo+PiA3
OjAzLjQ0DQo+PiA3OjA0LjgyDQo+PiA3OjAzLjI2DQo+PiA3OjA0Ljc0DQo+Pg0KPj4gRFVUNDoN
Cj4+IEZVQToNCj4+IDc6MjMuOTINCj4+IDc6MjAuMTUNCj4+IDc6MjAuNTINCj4+IDc6MTkuMTAN
Cj4+IDc6MjAuNzENCj4+IENhY2hlLCBubyBGVUE6DQo+PiA3OjIwLjIzDQo+PiA3OjIwLjQ4DQo+
PiA3OjE5Ljk0DQo+PiA3OjE4LjkwDQo+PiA3OjE5Ljg4DQo+DQo+IFdpdGhvdXQgZ29pbmcgaW50
byB0aGUgZGV0YWlscyBvZiB0aGUgYWJvdmUsIGl0IHNlZW1zIGxpa2UgZm9yIERVVDEsIERVVDIs
IERVVDMgYW5kIERVVDQgdGhlcmUgYSBnb29kIHJlYXNvbnMgdG8gd2h5IHdlIHNob3VsZCBtb3Zl
IGZvcndhcmQgd2l0aCAkc3ViamVjdCBwYXRjaC4NCj4NCj4gRG8geW91IGFncmVlPw0KDQpUaGF0
IGlzIGEgZ29vZCBxdWVzdGlvbiwgdGhhdCdzIHdoeSBJIGp1c3QgcG9zdGVkIHRoZSBkYXRhIHdp
dGhvdXQgZnVydGhlciBjb21tZW50IGZyb20gbXkgc2lkZS4NCkkgd2FzIGhvbmVzdGx5IGV4cGVj
dGluZyB0aGUgZGlmZmVyZW5jZSB0byBiZSBtdWNoIGhpZ2hlciwgZ2l2ZW4gdGhlIG9yaWdpbmFs
IHBhdGNoLg0KSWYgdGhpcyBpcyByZXByZXNlbnRhdGl2ZSBmb3IgbW9zdCBjYXJkcywgeW91IHdv
dWxkIHJlcXVpcmUgcXVpdGUgYW4gdW51c3VhbCB3b3JrbG9hZCB0byBhY3R1YWxseSBub3RpY2Ug
dGhlIGRpZmZlcmVuY2UgSU1PLg0KSWYgdGhlcmUgYXJlIGNhcmRzIHdoZXJlIHRoZSBkaWZmZXJl
bmNlIGlzIG11Y2ggbW9yZSBzaWduaWZpY2FudCB0aGVuIG9mIGNvdXJzZSBhIHF1aXJrIHdvdWxk
IGJlIG5pY2VyLg0KT24gdGhlIG90aGVyIHNpZGUgSSBkb24ndCBzZWUgd2h5IG5vdCBhbmQgYW55
IGltcHJvdmVtZW50IGlzIGEgZ29vZCBvbmU/DQoNCj4NCj4+DQo+PiBDYWNoZSwgbm8gRlVBOg0K
Pj4gNzoxOS4zNg0KPj4gNzowMi4xMQ0KPj4gNzowMS41Mw0KPj4gNzowMS4zNQ0KPj4gNzowMC4z
Nw0KPj4gQ2FjaGUsIG5vIEZVQSBDUUU6DQo+PiA3OjE3LjU1DQo+PiA3OjAwLjczDQo+PiA2OjU5
LjI1DQo+PiA2OjU4LjQ0DQo+PiA2OjU4LjYwDQo+PiBGVUE6DQo+PiA3OjE1LjEwDQo+PiA2OjU4
Ljk5DQo+PiA2OjU4Ljk0DQo+PiA2OjU5LjE3DQo+PiA2OjYwLjAwDQo+PiBGVUEgQ1FFOg0KPj4g
NzoxMS4wMw0KPj4gNjo1OC4wNA0KPj4gNjo1Ni44OQ0KPj4gNjo1Ni40Mw0KPj4gNjo1NjoyOA0K
Pj4NCj4+IElmIGFueW9uZSBoYXMgYW55IGNvbW1lbnRzIG9yIGRpc2FncmVlcyB3aXRoIHRoZSBi
ZW5jaG1hcmssIG9yIGhhcyBhIHNwZWNpZmljIGVNTUMgdG8gdGVzdCwgbGV0IG1lIGtub3cuDQo+
DQo+IElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIGZvciBEVVQ1LCBpdCBzZWVtcyBsaWtlIHVz
aW5nIEZVQSBtYXkgYmUgc2xpZ2h0bHkgYmV0dGVyIHRoYW4ganVzdCBjYWNoZS1mbHVzaGluZywg
cmlnaHQ/DQoNClRoYXQgaXMgY29ycmVjdCwgSSBzcGVjaWZpY2FsbHkgdGVzdGVkIHdpdGggdGhp
cyBjYXJkIGFzIHVuZGVyIHRoZSBhc3N1bXB0aW9uIHRoYXQgcmVsaWFibGUgd3JpdGUgaXMgd2l0
aG91dCBtdWNoIGFkZGl0aW9uYWwgY29zdCwgdGhlIERDTUQgd291bGQgYmUgc2xpZ2h0bHkgd29y
c2UgZm9yIHBlcmZvcm1hbmNlIGFuZCBTWU5DIGEgYml0IHdvcnNlLg0KDQo+DQo+IEZvciBDUUUs
IGl0IHNlZW1zIGxpa2UgRlVBIGNvdWxkIGJlIHNsaWdodGx5IGV2ZW4gYmV0dGVyLCBhdCBsZWFz
dCBmb3IgRFVUNS4gIERvIHlvdSBrbm93IGlmIFJFUV9PUF9GTFVTSCB0cmFuc2xhdGVzIGludG8g
TU1DX0lTU1VFX0RDTUQgb3IgTU1DX0lTU1VFX1NZTkMgZm9yIHlvdXIgY2FzZT8gU2VlIG1tY19j
cWVfaXNzdWVfdHlwZSgpLg0KSXQgaXMgU1lOQyAodGhpcyBpcyBzZGhjaS1vZi1hcmFzYW4gb24g
cmszMzk5LCBubyBEQ01EKSwgYnV0IGV2ZW4gU1lOQyBpcyBub3QgdG9vIGJhZCBoZXJlIGl0IHNl
ZW1zLCBjb3VsZCBvZiBjb3Vyc2UgYmUgd29yc2UgaWYgdGhlIHdvcmtsb2FkIHdhcyBsZXNzIHNl
cXVlbnRpYWwuDQoNCj4NCj4gV2hlbiBpdCBjb21lcyB0byBDUUUsIG1heWJlIEFkcmlhbiBoYXZl
IHNvbWUgYWRkaXRpb25hbCB0aG91Z2h0cyBhcm91bmQgdGhpcz8gUGVyaGFwcyB3ZSBzaG91bGQg
a2VlcCB1c2luZyBSRVFfRlVBLCBpZiB3ZSBoYXZlIENRRT8NClN1cmUsIEknbSBhbHNvIGludGVy
ZXN0ZWQgaW4gQWRyaWFuJ3MgdGFrZSBvbiB0aGlzLg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuDQoN
Ckh5cGVyc3RvbmUgR21iSCB8IFJlaWNoZW5hdXN0ci4gMzlhICB8IDc4NDY3IEtvbnN0YW56Ck1h
bmFnaW5nIERpcmVjdG9yOiBEci4gSmFuIFBldGVyIEJlcm5zLgpDb21tZXJjaWFsIHJlZ2lzdGVy
IG9mIGxvY2FsIGNvdXJ0czogRnJlaWJ1cmcgSFJCMzgxNzgy

