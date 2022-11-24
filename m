Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549BF6375A9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiKXJz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiKXJzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:55:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C096133957;
        Thu, 24 Nov 2022 01:55:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBD2DB8273E;
        Thu, 24 Nov 2022 09:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8261EC433D7;
        Thu, 24 Nov 2022 09:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669283708;
        bh=5kaoiogge2CYIRkqs7Z6Uu8+iginiulfFRFqfLUtw0g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Oji2yPLYW7Lu/Or6kTo49asVjl4SI3j0UlBjpUg3bqJCUkx1Z+scI4jdQLep66Rhj
         M3eLxaMpJKjcH+Vbo3/0AsB9W08VyKnaLeG2ksn4CLFXw7BRAwf++qjuxdMHii2wT3
         HU/PjU5+XDUCuB0gn6g/FMJhVojIbRg4oHr/Fy85jrvwVuacWyaz1kX1j1L9K9xqiq
         AVtXSUCT2APz2ZMCltBOeUd0Utn3w5PIFCbqrCahQ4gFWydgwfPyzADXrFfxvU9sPb
         K0220O8TRH0s+Qi/mVNoGoRvCHDItM1i7Lhum09nIY8+WPiUMpFvRvGAhezzH0OTSZ
         Ct/TK5axZChYQ==
Received: by mail-ed1-f54.google.com with SMTP id z18so1812303edb.9;
        Thu, 24 Nov 2022 01:55:08 -0800 (PST)
X-Gm-Message-State: ANoB5pktl7a3vOGp549AelxMbkkYeIAPPayJYz1ShumyxfrbU4YayGSy
        CiZw5x2BnVmJEeAwDYFBWWB8f0CCfvuGuY41NBA=
X-Google-Smtp-Source: AA0mqf6uCf7DOW+G4EorXIvJeHLYegfrRCikQfgD6PTITzF4WYxsHRL/hxCaLiQi8oHYLJbosvZBptwkLJT2qgHdxlk=
X-Received: by 2002:a05:6402:10d1:b0:467:7508:89ca with SMTP id
 p17-20020a05640210d100b00467750889camr14616991edu.284.1669283706749; Thu, 24
 Nov 2022 01:55:06 -0800 (PST)
MIME-Version: 1.0
References: <1669123257-18550-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1669123257-18550-1-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 24 Nov 2022 17:54:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5=BB3=AJ9K=u_6pqxAz9Orr0zBFM7nOafEtkL-PjttUw@mail.gmail.com>
Message-ID: <CAAhV-H5=BB3=AJ9K=u_6pqxAz9Orr0zBFM7nOafEtkL-PjttUw@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN/LoongArch: Fix wrong description of FPRs Note
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>, loongarch@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXBwbGllZCB0byBsb29uZ2FyY2gtZml4ZXMsIHRoYW5rcy4NCg0KT24gVHVlLCBOb3YgMjIsIDIw
MjIgYXQgOToyMSBQTSBUaWV6aHUgWWFuZyA8eWFuZ3RpZXpodUBsb29uZ3Nvbi5jbj4gd3JvdGU6
DQo+DQo+IFRoZSBDaGluZXNlIHRyYW5zbGF0aW9uIG9mIEZQUnMgTm90ZSBpcyBub3QgY29uc2lz
dGVudCB3aXRoIHRoZSBvcmlnaW5hbA0KPiBFbmdsaXNoIHZlcnNpb24sICR2MC8kdjEgc2hvdWxk
IGJlICRmdjAvJGZ2MSwgJGEwLyRhMSBzaG91bGQgYmUgJGZhMC8kZmExLA0KPiBmaXggdGhlbS4N
Cj4NCj4gU2lnbmVkLW9mZi1ieTogVGllemh1IFlhbmcgPHlhbmd0aWV6aHVAbG9vbmdzb24uY24+
DQo+IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vbG9vbmdhcmNoL2lu
dHJvZHVjdGlvbi5yc3QgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3RyYW5z
bGF0aW9ucy96aF9DTi9sb29uZ2FyY2gvaW50cm9kdWN0aW9uLnJzdCBiL0RvY3VtZW50YXRpb24v
dHJhbnNsYXRpb25zL3poX0NOL2xvb25nYXJjaC9pbnRyb2R1Y3Rpb24ucnN0DQo+IGluZGV4IDEy
ODg3OGYuLmYzZWMyNWIgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25z
L3poX0NOL2xvb25nYXJjaC9pbnRyb2R1Y3Rpb24ucnN0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24v
dHJhbnNsYXRpb25zL3poX0NOL2xvb25nYXJjaC9pbnRyb2R1Y3Rpb24ucnN0DQo+IEBAIC03MCw4
ICs3MCw4IEBAIExBNjTkuK3mr4/kuKrlr4TlrZjlmajkuLo2NOS9jeWuveOAgiBgYCRyMGBgIOea
hOWGheWuueaAu+aYr+WbuuWumuS4ujDvvIzogIzlhbYNCj4gID09PT09PT09PT09PT09PT09ID09
PT09PT09PT09PT09PT09PSA9PT09PT09PT09PT09PT09PT09ID09PT09PT09PT0NCj4NCj4gIC4u
IG5vdGU6Og0KPiAtICAgIOazqOaEj++8muWcqOS4gOS6m+mBl+eVmeS7o+eggeS4reacieaXtuWP
r+iDveingeWIsCBgYCR2MGBgIOWSjCBgYCR2MWBgIO+8jOWug+S7rOaYrw0KPiAtICAgIGBgJGEw
YGAg5ZKMIGBgJGExYGAg55qE5Yir5ZCN77yM5bGe5LqO5bey57uP5bqf5byD55qE55So5rOV44CC
DQo+ICsgICAg5rOo5oSP77ya5Zyo5LiA5Lqb6YGX55WZ5Luj56CB5Lit5pyJ5pe25Y+v6IO96KeB
5YiwIGBgJGZ2MGBgIOWSjCBgYCRmdjFgYCDvvIzlroPku6zmmK8NCj4gKyAgICBgYCRmYTBgYCDl
kowgYGAkZmExYGAg55qE5Yir5ZCN77yM5bGe5LqO5bey57uP5bqf5byD55qE55So5rOV44CCDQo+
DQo+DQo+ICDlkJHph4/lr4TlrZjlmagNCj4gLS0NCj4gMi4xLjANCj4NCg==
