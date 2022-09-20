Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E54A5BE16B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiITJJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiITJIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:08:18 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB3A1057E;
        Tue, 20 Sep 2022 02:06:47 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r18so4483017eja.11;
        Tue, 20 Sep 2022 02:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=AmCAcnHGGiwJk7wwWsNfVxFK/3b3sztbC0O1Vae3nNE=;
        b=Ozai8tkslzkea/8DIQ83DCxlVrZjdlILmfRSGlzTo7VBAGX40x7fLNYdHxHly8IrVd
         u9WlE578h31fvzCe1eyglLsA3HrH8rRkNB0KhRHmP1dnhc4pAJWqbHrbgj5xiFm4fphe
         PB4m3iEVkS3J5qkpURmxshgsSgZDIP+DNNEd1g6DH+KOqE6LoTJBj3P24Zxj0PKsyIu/
         CuBAmdF4mpS1EeTm7iRzA7aFO50a7ur6sD4HZCDKnQSMRvZNkkLqXaXUJeDRJmcmO24J
         W18KrlgRDRwR9XRT9vRuX3bBHjC3SyCkIhdIlA3SwUaVrFQasJMJSVPUjb3tJid4/cZ+
         dpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=AmCAcnHGGiwJk7wwWsNfVxFK/3b3sztbC0O1Vae3nNE=;
        b=FgMQVstrXHa3XyrPMSYbM2u4jB1JNAc9gvH+SQkBPhHpJ2+evQJULhNzZPT5unyYTD
         oUIinMbItXpJnpa1ZQioIqaFmucNkGc2ifKeJ+G4ZCsdcpIsXNiUz1IV2BLTWENdZEaR
         RnEM/V95J/uWkqfobRs0ME588DRfZROoDULz9J9OkfmSq8P3rw+tJTASz7kDEzHSXMDP
         xFtFnYcFZIC7mjZ1/Q3Y69z+rX7Lh1AuicDUJqwwDa3Df7rjp8CTWKrajCOC9iae42Sj
         oa7k8qyHLwHrjYaWO7t9vsOSAV+ImjwrKe6e9jAFfE99PoFR/1DMMnjBrJ9fW+Hb8J7R
         ob4Q==
X-Gm-Message-State: ACrzQf15IqF/ivsPDY2wa/De47k0DLYTcbk+nQG7e92/2pYgMv8GYfUL
        1eyT+VOxlnnLBeHWcZOfhKTYaCTE05xyrl4r
X-Google-Smtp-Source: AMsMyM61yxzK4HcfVYb0NsyAno7BvcQxUSILJtD/6MWtjwOCDRQfQ6nesRJymFp22XGw2JytA73dcA==
X-Received: by 2002:a17:907:7d9e:b0:771:db66:7b7c with SMTP id oz30-20020a1709077d9e00b00771db667b7cmr15937954ejc.393.1663664806106;
        Tue, 20 Sep 2022 02:06:46 -0700 (PDT)
Received: from [10.176.234.249] ([137.201.254.41])
        by smtp.googlemail.com with ESMTPSA id q22-20020a17090676d600b00777557d1ea2sm532764ejn.47.2022.09.20.02.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 02:06:45 -0700 (PDT)
Message-ID: <f1f0a0a55d8c6ef3e02ca210eaa1096ebe71f9a9.camel@gmail.com>
Subject: Re: [PATCH] scsi: ufs: Remove redundant function definitions from
 ufshcd.h
From:   Bean Huo <huobean@gmail.com>
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        martin.petersen@oracle.com
Cc:     avri.altman@wdc.com, Avi.Shchislowski@wdc.com, beanhuo@micron.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org
Date:   Tue, 20 Sep 2022 11:06:44 +0200
In-Reply-To: <1663575664-27358-1-git-send-email-Arthur.Simchaev@wdc.com>
References: <1663575664-27358-1-git-send-email-Arthur.Simchaev@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFydGh1ciwKCgpPbiBNb24sIDIwMjItMDktMTkgYXQgMTE6MjEgKzAzMDAsIEFydGh1ciBT
aW1jaGFldiB3cm90ZToKPiBUaGlzIHBhdGNoIHJlbW92ZXMgUXVlcnktUmVxdWVzdCBBUEkgZnVu
Y3Rpb25zIGRlY2xhcmF0aW9uIGZyb20KPiBmcm9tIGluY2x1ZGUvdWZzL3Vmc2hjZC5oLiBUaG9z
ZSBkZWNsYXJhdGlvbnMgYmVsb25ncyBzb2xlbHkgdG8KICAgXiB1bm5lY2Vzc2FyeSAiZnJvbSIg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5iZWxvbmcKCj4gdWZzIGNvcmUgcHJpdmV0IGhl
YWRlci4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBBcnRodXIgU2ltY2hhZXYgPEFydGh1ci5TaW1jaGFl
dkB3ZGMuY29tPgo+IC0tLQo+IMKgZHJpdmVycy91ZnMvY29yZS91ZnNoY2QtcHJpdi5oIHzCoCA1
ICsrKysrCj4gwqBpbmNsdWRlL3Vmcy91ZnNoY2QuaMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTkg
Ky0tLS0tLS0tLS0tLS0tLS0tLQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyks
IDE4IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vmcy9jb3JlL3Vmc2hj
ZC1wcml2LmgKPiBiL2RyaXZlcnMvdWZzL2NvcmUvdWZzaGNkLXByaXYuaAo+IGluZGV4IGQwMGRi
YTEuLmY2OGNhMzMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy91ZnMvY29yZS91ZnNoY2QtcHJpdi5o
Cj4gKysrIGIvZHJpdmVycy91ZnMvY29yZS91ZnNoY2QtcHJpdi5oCj4gQEAgLTQyLDYgKzQyLDEx
IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCB1ZnNfaHdtb25fcmVtb3ZlKHN0cnVjdCB1ZnNfaGJhCj4g
KmhiYSkge30KPiDCoHN0YXRpYyBpbmxpbmUgdm9pZCB1ZnNfaHdtb25fbm90aWZ5X2V2ZW50KHN0
cnVjdCB1ZnNfaGJhICpoYmEsIHU4Cj4gZWVfbWFzaykge30KPiDCoCNlbmRpZgo+IMKgCj4gK2lu
dCB1ZnNoY2RfcXVlcnlfZGVzY3JpcHRvcl9yZXRyeShzdHJ1Y3QgdWZzX2hiYSAqaGJhLAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGVudW0gcXVlcnlfb3Bjb2RlIG9wY29kZSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnVtIGRlc2NfaWRu
IGlkbiwgdTggaW5kZXgsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTggc2VsZWN0b3IsCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTggKmRl
c2NfYnVmLCBpbnQgKmJ1Zl9sZW4pOwo+IMKgaW50IHVmc2hjZF9yZWFkX2Rlc2NfcGFyYW0oc3Ry
dWN0IHVmc19oYmEgKmhiYSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGVudW0gZGVzY19pZG4gZGVzY19pZCwKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludCBkZXNjX2luZGV4LAo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL3Vmcy91ZnNoY2QuaCBiL2luY2x1ZGUvdWZzL3Vmc2hjZC5oCj4g
aW5kZXggMjRjOTdlMC4uMzY0N2E3MSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3Vmcy91ZnNoY2Qu
aAo+ICsrKyBiL2luY2x1ZGUvdWZzL3Vmc2hjZC5oCj4gQEAgLTExNzYsMjQgKzExNzYsNyBAQCBz
dGF0aWMgaW5saW5lIGludAo+IHVmc2hjZF9kaXNhYmxlX2hvc3RfdHhfbGNjKHN0cnVjdCB1ZnNf
aGJhICpoYmEpCj4gwqB9Cj4gwqAKPiDCoC8qIEV4cG9zZSBRdWVyeS1SZXF1ZXN0IEFQSSAqLwpU
aGlzIGNvbW1lbnQgc2hvdWxkIGJlIHJlbW92ZWQsIHRvbz8KCgoKUmV2aWV3ZWQtYnk6IEJlYW4g
SHVvIDxiZWFuaHVvQG1pY3Jvbi5jb20+CgoKS2luZCByZWdhcmRzLApCZWFuCg==

