Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7225ED7CC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbiI1Ibw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiI1Ibq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:31:46 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D09088A09;
        Wed, 28 Sep 2022 01:31:43 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 130-20020a1c0288000000b003b494ffc00bso164388wmc.0;
        Wed, 28 Sep 2022 01:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:cc:to:from:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=ueJxdck7hKcZeFo8WGIQFZqWuWyNs8oLQTDGNzuINkg=;
        b=LwVOUx/1UrNxzp4lWFkMJupkRc+dnDO99BHng5ipaMd80tEfAR4ucYFuoM+Pn5nNgw
         iwPFt7SBuGJLWFMS+C4Q+UXaqqr5oQbSDA7hPIPgsI+qGRYvkUiTqYOKo+xJC5gNDXOS
         BCn4hdC/+VVf/X5w11tLiE77XUJr/DtcWRvq7lcXRIZ7eP7ka55nY0bAvZucS0elDFlD
         hCf3ZTekEgBq9gaa4mVpmKKxsP24q+OqSy1ORs6/olzBK7IT3mYi2BMD9Xk6eMaq3wt1
         ckuHTr03O3LWolLwawYw1lHtfd/BovjUGNKq6PBWdsNyUBN+4QlEstYOLes+yrNLZTjd
         3kvA==
X-Gm-Message-State: ACrzQf3vMjf132JenVvqNmCouXLV2A4aq0crQElBS1sLSxIOq/xAZK3j
        EwpBbaqJKnGeTVWsjvKqExk=
X-Google-Smtp-Source: AMsMyM53aP8IjHC0zPw3a9vv33BKMndVPixb8TLTuO9a41VPh8h1D9FaV0BVer9h+5lH0GYAp86htQ==
X-Received: by 2002:a05:600c:5254:b0:3b5:99c:9be1 with SMTP id fc20-20020a05600c525400b003b5099c9be1mr5982210wmb.172.1664353901692;
        Wed, 28 Sep 2022 01:31:41 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id v15-20020adfedcf000000b00228cbac7a25sm3648516wro.64.2022.09.28.01.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 01:31:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------0vtBb7FM7oUJt59bIjiHZKlR"
Message-ID: <498a9097-8ecf-0a47-abbb-8b64fb7ee2de@kernel.org>
Date:   Wed, 28 Sep 2022 10:31:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v6] ACPI: skip IRQ override on AMD Zen platforms
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Chuanhong Guo <gch981213@gmail.com>, linux-acpi@vger.kernel.org
Cc:     Tighe Donnelly <tighe.donnelly@protonmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220712020058.90374-1-gch981213@gmail.com>
 <0450c7c0-4787-2aa2-de3e-c71522e467ce@kernel.org>
In-Reply-To: <0450c7c0-4787-2aa2-de3e-c71522e467ce@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0vtBb7FM7oUJt59bIjiHZKlR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28. 09. 22, 8:20, Jiri Slaby wrote:
> Hi,
> 
> On 12. 07. 22, 4:00, Chuanhong Guo wrote:
>> IRQ override isn't needed on modern AMD Zen systems.
>> There's an active low keyboard IRQ on AMD Ryzen 6000 and it will stay
>> this way on newer platforms. This IRQ override breaks keyboards for
>> almost all Ryzen 6000 laptops currently on the market.
>>
>> Skip this IRQ override for all AMD Zen platforms because this IRQ
>> override is supposed to be a workaround for buggy ACPI DSDT and we can't
>> have a long list of all future AMD CPUs/Laptops in the kernel code.
>> If a device with buggy ACPI DSDT shows up, a separated list containing
>> just them should be created.
> 
> This breaks pads on IdeaPad 5 Flex:
> https://bugzilla.suse.com/show_bug.cgi?id=1203794
> 
>  > [    1.058135] hid-generic 0020:1022:0001.0001: hidraw0: SENSOR HUB 
> HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
>  > [    2.038937] i2c_designware AMDI0010:00: controller timed out
>  > [    2.146627] i2c_designware AMDI0010:03: controller timed out
>  > [    6.166859] i2c_hid_acpi i2c-MSFT0001:00: failed to reset device: -61
>  > [    8.279604] i2c_designware AMDI0010:03: controller timed out
>  > [   12.310897] i2c_hid_acpi i2c-MSFT0001:00: failed to reset device: -61
>  > [   14.429372] i2c_designware AMDI0010:03: controller timed out
>  > [   18.462629] i2c_hid_acpi i2c-MSFT0001:00: failed to reset device: -61
>  > [   20.579183] i2c_designware AMDI0010:03: controller timed out
>  > [   24.598703] i2c_hid_acpi i2c-MSFT0001:00: failed to reset device: -61
>  > [   25.629071] i2c_hid_acpi i2c-MSFT0001:00: can't add hid device: -61
>  > [   25.629430] i2c_hid_acpi: probe of i2c-MSFT0001:00 failed with 
> error -61
> 
> The diff of good and bad dmesgs:
> -ACPI: IRQ 10 override to edge, high
> -ACPI: IRQ 6 override to edge, high
> 
> The diff of /proc/interrupts:
>       6: ...  IR-IO-APIC    [-6-fasteoi-]    {+6-edge+}      AMDI0010:03
>      10: ...  IR-IO-APIC   [-10-fasteoi-]   {+10-edge+}      AMDI0010:00
> 
> And:
>    i2c_designware: /devices/platform/AMDI0010:00
>    i2c_designware: /devices/platform/AMDI0010:03
> 
> 
> So the if needs to be fine-tuned, apparently. Maybe introduce some list 
> as suggested in the commit log. Based on the below?

Something like the attached. It's:
1) untested yet
2) contains more debug messaging
3) contains both cases for ACPI_ACTIVE_* as I don't know the original 
polarity

I don't know how widely this is spread -- maybe it would be worth a 
commandline parameter so that people can work around this until this is 
fixed by a DMI entry permanently?

> DMI says:
>    System Info: #14
>      Manufacturer: "LENOVO"
>      Product: "82RA"
>      Version: "IdeaPad Flex 5 16ALC7"
>      Serial: "PW02359K"
>      UUID: 6b2d54d9-cd80-11ec-83eb-e00af665fbac
>      Wake-up: 0x06 (Power Switch)
>    Board Info: #15
>      Manufacturer: "LENOVO"
>      Product: "LNVNB161216"
>      Version: "SDK0T76463 WIN"
>      Serial: "PW02359K"
>      Asset Tag: "No Asset Tag"
>      Type: 0x0a (Motherboard)
>      Features: 0x09
>        Hosting Board
>        Replaceable
>      Location: "Chassis Location Unknown"
>    Chassis Info: #16
>      Manufacturer: "LENOVO"
>      Version: "IdeaPad Flex 5 16ALC7"
>      Serial: "PW02359K"
>      Asset Tag: "No Asset Tag"
>      Type: 0x1f (Other)
>      Bootup State: 0x03 (Safe)
>      Power Supply State: 0x03 (Safe)
>      Thermal State: 0x01 (Other)
>      Security Status: 0x01 (Other)
> 
>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
>> ---
>> Change sice v5: reworked
>>
>>   drivers/acpi/resource.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index c2d494784425..510cdec375c4 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
>> @@ -416,6 +416,16 @@ static bool acpi_dev_irq_override(u32 gsi, u8 
>> triggering, u8 polarity,
>>   {
>>       int i;
>> +#ifdef CONFIG_X86
>> +    /*
>> +     * IRQ override isn't needed on modern AMD Zen systems and
>> +     * this override breaks active low IRQs on AMD Ryzen 6000 and
>> +     * newer systems. Skip it.
>> +     */
>> +    if (boot_cpu_has(X86_FEATURE_ZEN))
>> +        return false;
>> +#endif
>> +
>>       for (i = 0; i < ARRAY_SIZE(skip_override_table); i++) {
>>           const struct irq_override_cmp *entry = &skip_override_table[i];
> 
> thanks,

-- 
js

--------------0vtBb7FM7oUJt59bIjiHZKlR
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ACPI-resource-do-IRQ-override-on-LENOVO-IdeaPad.patch"
Content-Disposition: attachment;
 filename*0="0001-ACPI-resource-do-IRQ-override-on-LENOVO-IdeaPad.patch"
Content-Transfer-Encoding: base64

RnJvbSA0ODVkZDEyMjliOWQyZjMyMjg3OWQ4NTczMWFmNGE3OTUyYjljYzRiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKaXJpIFNsYWJ5IDxqc2xhYnlAc3VzZS5jej4KRGF0
ZTogV2VkLCAyOCBTZXAgMjAyMiAwOTo0MzowNSArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIEFD
UEk6IHJlc291cmNlOiBkbyBJUlEgb3ZlcnJpZGUgb24gTEVOT1ZPIElkZWFQYWQKCkxFTk9W
TyBJZGVhUGFkIEZsZXggNSBpcyByeXplbi01IGJhc2VkIGFuZCB0aGUgY29tbWl0IGJlbG93
IHJlbW92ZWQgaXJxCm92ZXJyaWRpbmcgZm9yIHRob3NlLiBUaGlzIGJyb2tlIHRvdWNoc2Ny
ZWVuIGFuZCB0cmFja3BhZDoKIGkyY19kZXNpZ253YXJlIEFNREkwMDEwOjAwOiBjb250cm9s
bGVyIHRpbWVkIG91dAogaTJjX2Rlc2lnbndhcmUgQU1ESTAwMTA6MDM6IGNvbnRyb2xsZXIg
dGltZWQgb3V0CiBpMmNfaGlkX2FjcGkgaTJjLU1TRlQwMDAxOjAwOiBmYWlsZWQgdG8gcmVz
ZXQgZGV2aWNlOiAtNjEKIGkyY19kZXNpZ253YXJlIEFNREkwMDEwOjAzOiBjb250cm9sbGVy
IHRpbWVkIG91dAogLi4uCiBpMmNfaGlkX2FjcGkgaTJjLU1TRlQwMDAxOjAwOiBjYW4ndCBh
ZGQgaGlkIGRldmljZTogLTYxCiBpMmNfaGlkX2FjcGk6IHByb2JlIG9mIGkyYy1NU0ZUMDAw
MTowMCBmYWlsZWQgd2l0aCBlcnJvciAtNjEKCldoaXRlIGxpc3QgdGhpcyBzcGVjaWZpYyBt
b2RlbCBpbiB0aGUgb3ZlcnJpZGVfdGFibGUuCgpGb3IgdGhpcyB0byB3b3JrLCB0aGUgWkVO
IHRlc3QgbmVlZHMgdG8gYmUgcHV0IGJlbG93IHRoZSB0YWJsZSB3YWxrLgoKRml4ZXM6IDM3
YzgxZDlmMWQxYiAoQUNQSTogcmVzb3VyY2U6IHNraXAgSVJRIG92ZXJyaWRlIG9uIEFNRCBa
ZW4gcGxhdGZvcm1zKQpTaWduZWQtb2ZmLWJ5OiBKaXJpIFNsYWJ5IDxqc2xhYnlAc3VzZS5j
ej4KLS0tCiBkcml2ZXJzL2FjcGkvcmVzb3VyY2UuYyB8IDUxICsrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMzUgaW5zZXJ0aW9u
cygrKSwgMTYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3Jlc291
cmNlLmMgYi9kcml2ZXJzL2FjcGkvcmVzb3VyY2UuYwppbmRleCBlNDBiMjE1MzkxMWQuLmFi
MjVlOTNjZjIyYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9hY3BpL3Jlc291cmNlLmMKKysrIGIv
ZHJpdmVycy9hY3BpL3Jlc291cmNlLmMKQEAgLTQxNywxNyArNDE3LDMzIEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgZG1pX3N5c3RlbV9pZCBhc3VzX2xhcHRvcFtdID0gewogCXsgfQogfTsK
IAorc3RhdGljIGNvbnN0IHN0cnVjdCBkbWlfc3lzdGVtX2lkIGxlbm92b19sYXB0b3BbXSA9
IHsKKwl7CisJCS5pZGVudCA9ICJMRU5PVk8gSWRlYVBhZCBGbGV4IDUgMTZBTEM3IiwKKwkJ
Lm1hdGNoZXMgPSB7CisJCQlETUlfTUFUQ0goRE1JX1NZU19WRU5ET1IsICJMRU5PVk8iKSwK
KwkJCURNSV9NQVRDSChETUlfUFJPRFVDVF9OQU1FLCAiODJSQSIpLAorCQl9LAorCX0sCisJ
eyB9Cit9OworCiBzdHJ1Y3QgaXJxX292ZXJyaWRlX2NtcCB7CiAJY29uc3Qgc3RydWN0IGRt
aV9zeXN0ZW1faWQgKnN5c3RlbTsKIAl1bnNpZ25lZCBjaGFyIGlycTsKIAl1bnNpZ25lZCBj
aGFyIHRyaWdnZXJpbmc7CiAJdW5zaWduZWQgY2hhciBwb2xhcml0eTsKIAl1bnNpZ25lZCBj
aGFyIHNoYXJlYWJsZTsKKwlib29sIG92ZXJyaWRlOwogfTsKIAotc3RhdGljIGNvbnN0IHN0
cnVjdCBpcnFfb3ZlcnJpZGVfY21wIHNraXBfb3ZlcnJpZGVfdGFibGVbXSA9IHsKLQl7IG1l
ZGlvbl9sYXB0b3AsIDEsIEFDUElfTEVWRUxfU0VOU0lUSVZFLCBBQ1BJX0FDVElWRV9MT1cs
IDAgfSwKLQl7IGFzdXNfbGFwdG9wLCAxLCBBQ1BJX0xFVkVMX1NFTlNJVElWRSwgQUNQSV9B
Q1RJVkVfTE9XLCAwIH0sCitzdGF0aWMgY29uc3Qgc3RydWN0IGlycV9vdmVycmlkZV9jbXAg
b3ZlcnJpZGVfdGFibGVbXSA9IHsKKwl7IG1lZGlvbl9sYXB0b3AsIDEsIEFDUElfTEVWRUxf
U0VOU0lUSVZFLCBBQ1BJX0FDVElWRV9MT1csIDAsIGZhbHNlIH0sCisJeyBhc3VzX2xhcHRv
cCwgMSwgQUNQSV9MRVZFTF9TRU5TSVRJVkUsIEFDUElfQUNUSVZFX0xPVywgMCwgZmFsc2Ug
fSwKKwl7IGxlbm92b19sYXB0b3AsIDYsIEFDUElfRURHRV9TRU5TSVRJVkUsIEFDUElfQUNU
SVZFX0xPVywgMCwgdHJ1ZSB9LAorCXsgbGVub3ZvX2xhcHRvcCwgMTAsIEFDUElfRURHRV9T
RU5TSVRJVkUsIEFDUElfQUNUSVZFX0xPVywgMCwgdHJ1ZSB9LAorCXsgbGVub3ZvX2xhcHRv
cCwgNiwgQUNQSV9FREdFX1NFTlNJVElWRSwgQUNQSV9BQ1RJVkVfSElHSCwgMCwgdHJ1ZSB9
LAorCXsgbGVub3ZvX2xhcHRvcCwgMTAsIEFDUElfRURHRV9TRU5TSVRJVkUsIEFDUElfQUNU
SVZFX0hJR0gsIDAsIHRydWUgfSwKIH07CiAKIHN0YXRpYyBib29sIGFjcGlfZGV2X2lycV9v
dmVycmlkZSh1MzIgZ3NpLCB1OCB0cmlnZ2VyaW5nLCB1OCBwb2xhcml0eSwKQEAgLTQzNSw2
ICs0NTEsMTcgQEAgc3RhdGljIGJvb2wgYWNwaV9kZXZfaXJxX292ZXJyaWRlKHUzMiBnc2ks
IHU4IHRyaWdnZXJpbmcsIHU4IHBvbGFyaXR5LAogewogCWludCBpOwogCisJZm9yIChpID0g
MDsgaSA8IEFSUkFZX1NJWkUob3ZlcnJpZGVfdGFibGUpOyBpKyspIHsKKwkJY29uc3Qgc3Ry
dWN0IGlycV9vdmVycmlkZV9jbXAgKmVudHJ5ID0gJm92ZXJyaWRlX3RhYmxlW2ldOworCisJ
CWlmIChkbWlfY2hlY2tfc3lzdGVtKGVudHJ5LT5zeXN0ZW0pICYmCisJCSAgICBlbnRyeS0+
aXJxID09IGdzaSAmJgorCQkgICAgZW50cnktPnRyaWdnZXJpbmcgPT0gdHJpZ2dlcmluZyAm
JgorCQkgICAgZW50cnktPnBvbGFyaXR5ID09IHBvbGFyaXR5ICYmCisJCSAgICBlbnRyeS0+
c2hhcmVhYmxlID09IHNoYXJlYWJsZSkKKwkJCXJldHVybiBlbnRyeS0+b3ZlcnJpZGU7CisJ
fQorCiAjaWZkZWYgQ09ORklHX1g4NgogCS8qCiAJICogSVJRIG92ZXJyaWRlIGlzbid0IG5l
ZWRlZCBvbiBtb2Rlcm4gQU1EIFplbiBzeXN0ZW1zIGFuZApAQCAtNDQ1LDE3ICs0NzIsNiBA
QCBzdGF0aWMgYm9vbCBhY3BpX2Rldl9pcnFfb3ZlcnJpZGUodTMyIGdzaSwgdTggdHJpZ2dl
cmluZywgdTggcG9sYXJpdHksCiAJCXJldHVybiBmYWxzZTsKICNlbmRpZgogCi0JZm9yIChp
ID0gMDsgaSA8IEFSUkFZX1NJWkUoc2tpcF9vdmVycmlkZV90YWJsZSk7IGkrKykgewotCQlj
b25zdCBzdHJ1Y3QgaXJxX292ZXJyaWRlX2NtcCAqZW50cnkgPSAmc2tpcF9vdmVycmlkZV90
YWJsZVtpXTsKLQotCQlpZiAoZG1pX2NoZWNrX3N5c3RlbShlbnRyeS0+c3lzdGVtKSAmJgot
CQkgICAgZW50cnktPmlycSA9PSBnc2kgJiYKLQkJICAgIGVudHJ5LT50cmlnZ2VyaW5nID09
IHRyaWdnZXJpbmcgJiYKLQkJICAgIGVudHJ5LT5wb2xhcml0eSA9PSBwb2xhcml0eSAmJgot
CQkgICAgZW50cnktPnNoYXJlYWJsZSA9PSBzaGFyZWFibGUpCi0JCQlyZXR1cm4gZmFsc2U7
Ci0JfQotCiAJcmV0dXJuIHRydWU7CiB9CiAKQEAgLTQ4Nyw4ICs1MDMsMTEgQEAgc3RhdGlj
IHZvaWQgYWNwaV9kZXZfZ2V0X2lycXJlc291cmNlKHN0cnVjdCByZXNvdXJjZSAqcmVzLCB1
MzIgZ3NpLAogCQl1OCBwb2wgPSBwID8gQUNQSV9BQ1RJVkVfTE9XIDogQUNQSV9BQ1RJVkVf
SElHSDsKIAogCQlpZiAodHJpZ2dlcmluZyAhPSB0cmlnIHx8IHBvbGFyaXR5ICE9IHBvbCkg
ewotCQkJcHJfd2FybigiQUNQSTogSVJRICVkIG92ZXJyaWRlIHRvICVzLCAlc1xuIiwgZ3Np
LAotCQkJCXQgPyAibGV2ZWwiIDogImVkZ2UiLCBwID8gImxvdyIgOiAiaGlnaCIpOworCQkJ
cHJfd2FybigiQUNQSTogSVJRICVkIG92ZXJyaWRlIHRvICVzJXMsICVzJXNcbiIsIGdzaSwK
KwkJCQl0ID8gImxldmVsIiA6ICJlZGdlIiwKKwkJCQl0cmlnID09IHRyaWdnZXJpbmcgPyAi
IiA6ICIoISkiLAorCQkJCXAgPyAibG93IiA6ICJoaWdoIiwKKwkJCQlwb2wgPT0gcG9sYXJp
dHkgPyAiIiA6ICIoISkiKTsKIAkJCXRyaWdnZXJpbmcgPSB0cmlnOwogCQkJcG9sYXJpdHkg
PSBwb2w7CiAJCX0KLS0gCjIuMzcuMwoK

--------------0vtBb7FM7oUJt59bIjiHZKlR--
