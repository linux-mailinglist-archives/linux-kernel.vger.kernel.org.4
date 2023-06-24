Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A7B73CA83
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 13:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjFXLDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 07:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjFXLDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 07:03:12 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFF31FCC
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 04:03:10 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id ffacd0b85a97d-307d20548adso1416744f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 04:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687604589; x=1690196589;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uWlmWiEB6BmaQ5aMZXNTRW6zBvIP1GA4SAnOLLL87qk=;
        b=rRoLKXMDxM96XpzlxIcxq7KXZOz5vV+k9xOwvYD00JgufQrv1+JlckRUxos5va5jg/
         JPuy8R4W4HXpLAg6zHiNH6Rod3oiiCa4D5A3kbYekFNis/Pfedem4eXUTS0JkhDy+Bwu
         iYa9ezMf11nfgfw8KhBzzqFiNPOxYIvvjDkI6Cmv3bkUvLg4A5Crm+lWa7OmaxfHKf9t
         EpCyc/2Vl0f4XBcJ3KcnMH4yetOTdcBDlpIMB6t3aOyzrA6/jb+yVlyRhz7LfPkntsAc
         xfsGa4q1ybRQNqJ/EAYMRqjXki6KY6czGJakeCZIXclNyf5c9Wt7whkcauz+RMWBYBOm
         8XrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687604589; x=1690196589;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWlmWiEB6BmaQ5aMZXNTRW6zBvIP1GA4SAnOLLL87qk=;
        b=kFUBV3UMQ+W95G1G9PCKQ0ioUiutVgAQEs6j+/MXvIezpFYQUuzA33iV9oAzRqU8NB
         1FH51A1vNvZKdl7ajXet7OWCN8IaFJa4GbiEL3UBBO/2RvAdyI9JlYY88Y/bAbE0PjkA
         Iaxk3wlCPDUIC6s6Xo2bynH2ZrnKdM5NfAWLHDWgjH0ZfP89nwenorjXvzpme08YzVQR
         QI37jLBteMVEBW432PI0CyP9OZ3ObcC5z29Kie4O2kPt3UhUFMSlCLO1SCEEunbG8Ma4
         a1Qyyv0KAgu2Zi1RFVLsCNZpJHyxrWZi9WSRGO/fATRqAi6liY+2o2TAlFeIO0QoU2tH
         62GQ==
X-Gm-Message-State: AC+VfDwYLLDNR3sjysD/tvn7laBAfm/QhPv48KiEcJrOCYpPfL8OfGxG
        VrSZDlWectPoWEyTc1vdrz7dCGwC0s/IoURzRHk=
X-Google-Smtp-Source: ACHHUZ5lz0OIvs4Jz3rdm/oCfwIcRuv3QcLrshJaw/P/DTNFy7Vg+exfNQApSkpNNb6nbMImU1PRBcqqc/sX1woOkUM=
X-Received: by 2002:a5d:570b:0:b0:309:53f3:6e3e with SMTP id
 a11-20020a5d570b000000b0030953f36e3emr14928192wrv.69.1687604588599; Sat, 24
 Jun 2023 04:03:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:e9c3:0:b0:30f:b6a9:506b with HTTP; Sat, 24 Jun 2023
 04:03:08 -0700 (PDT)
Reply-To: wu.wuheadofficemts.wu.tg@gmail.com
From:   Western Union <westernunlon572@gmail.com>
Date:   Sat, 24 Jun 2023 11:03:08 +0000
Message-ID: <CAO-W+sTi=S+KnhrEATGFvOXSCc2RnvgxBn+7WoaH+qfmCj902A@mail.gmail.com>
Subject: =?UTF-8?B?UG96b3I6IFbDocW+ZW7DvSBwxZnDrWplbWNp?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:443 listed in]
        [list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0091]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [westernunlon572[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [westernunlon572[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.5 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UG96b3I6IFbDocW+ZW7DvSBwxZnDrWplbWNpDQoNCkJ1xI90ZSBpbmZvcm1vdsOhbmksIMW+ZSBq
c21lIG9iZHLFvmVsaSBzY2h2w6FsZW7DvSBzb3Vib3IgcGxhdGViIG9kDQpGRURFUsOBTE7DjUhP
IE1JTklTVEVSU1RWQSBGSU5BTkPDjSB2ZSBzcG9qZW7DrSBzIE1lemluw6Fyb2Ruw61tIG3Em25v
dsO9bQ0KZm9uZGVtIChNTUYpIG9kxaFrb2RuxJtuw60gb2LEm3TDrSBwb2R2b2R1IGEgdmHFoWUg
ZS1tYWlsb3bDoSBhZHJlc2EgamUgbWV6aQ0KdXZlZGVuw71taSBvYsSbxaVtaS4NCg0KUMOtxaFp
IHbDoW0sIGFieWNoIHbDoXMgaW5mb3Jtb3ZhbCwgxb5lIHbDoW0gYnVkZW1lIHphc8OtbGF0ICQ1
LjAwMC4wMCBVU0QNCmRlbm7EmyB6IG5hxaHDrSBrYW5jZWzDocWZZSB6ZGUsIHByb3Rvxb5lIGpz
bWUgZG9zdGFsaSBtYW5kw6F0IHDFmWV2w6lzdCB2YcWhaQ0KcGxub3Uga29tcGVuemHEjW7DrSBw
bGF0YnUgdmUgdsO9xaFpICQ4MDAuMDAwLjAwIFVTRCBvZCBNZXppbsOhcm9kbsOtaG8NCm3Em25v
dsOpaG8gZm9uZHUgKE1NRikgYSBGRURFUsOBTE7DjUhPIE1JTklTVEVSU1RWQSBGSU5BTkPDjS4g
VmHFoWUgb3NvYm7DrQ0KaWRlbnRpZmlrYcSNbsOtIMSNw61zbG8gcG9za3l0bnV0w6kgdMO9bWVt
IEkuTS5GIGplIENQUDA5MjBURy4NCg0KWmRlIGpzb3UgcGxhdGVibsOtIMO6ZGFqZSwga3RlcsOp
IHBvdcW+aWplbWUgayBwxZllZMOhbsOtIHZhxaHDrSBkZW5uw60gcGxhdGJ5Lg0KDQpKbcOpbm8g
b2Rlc8OtbGF0ZWxlOiBFbGFpbmUgSm9obnNvbg0KT3TDoXprYTogUGxhdGJhDQpPZHBvdsSbxI86
IEFubw0KxIzDoXN0a2E6ICQ1LjAwMC4wMCBVU0QNCk3Em3N0bzogTG9tZQ0KWmVtxJs6IFRvZ28N
Cg0KUE9aTsOBTUtBOiBNVENOIHbDoW0gYnVkZSB6YXNsw6FubyBwbyB2YcWhw60gb2Rwb3bEm2Rp
IGEgcG90dnJ6ZW7DrSBpbmZvcm1hY8OtDQpvIHZhxaFlbSBwxZnDrWplbWNpLCBhYnkgc2UgcMWZ
ZWRlxaFsbyBjaHlibsOpbXUgcMWZZW5vc3UuDQoNCsSMZWvDoW1lIG5hIHZhxaFpIG5hbMOpaGF2
b3Ugb2Rwb3bEm8SPLCBhYnljaG9tIG1vaGxpIHBva3JhxI1vdmF0IHYgcGxhdGLEmy4NCg0KVsOh
xaEgdsSbcm7DvSwNClZlZG91Y8OtIHBvYm/EjWt5Og0K
