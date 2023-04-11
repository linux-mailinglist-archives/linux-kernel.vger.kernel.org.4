Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03666DE0D3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjDKQSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjDKQRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:17:52 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E704212;
        Tue, 11 Apr 2023 09:16:49 -0700 (PDT)
Date:   Tue, 11 Apr 2023 18:16:44 +0200 (GMT+02:00)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1681229807; bh=uKtjoYbKhktr7/nGPcAk75+/mu0TF7uA+IjJqmhqVyw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=n1g3M+W+Uwtysoh+M3KHQuIzdOc3O870NZhyc5hP8vHkhoqmHsnRQpHBh6VFtoEVg
         nJH5/KgztbbMLImU1WJ/dtKWjFoh+vhvObTz4UQcIAMHKjGeT/0ce74kuuhxooF9U8
         Rb3I7Y5X85heDodSYbsgtgGqZNarqoBtH4yfNegY=
From:   =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <e656fc58-a910-44b3-adb2-56f952dd740e@t-8ch.de>
In-Reply-To: <CAOOmCE8z_UDs8dG0MqX+SFcvd-CTX12XXKzOrVOKDuvrPkyeCQ@mail.gmail.com>
References: <20230403211548.6253-1-jorge.lopez2@hp.com> <d5fbc118-3b33-44b8-a7b6-4738e121b170@t-8ch.de> <CAOOmCE8z_UDs8dG0MqX+SFcvd-CTX12XXKzOrVOKDuvrPkyeCQ@mail.gmail.com>
Subject: Re: [PATCH v7] Introduction-of-HP-BIOSCFG-driver-documentation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <e656fc58-a910-44b3-adb2-56f952dd740e@t-8ch.de>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge!


Apr 4, 2023 22:24:36 Jorge Lopez <jorgealtxwork@gmail.com>:

> Hi Thomas,
>
> BTW, I decided to submit all files individually to facilitate the
> review process.=C2=A0 Only Makefile and Kconfig files will be provided as=
 a
> single patch.
> I will be out of town until April 11 and will reply back upon my return.

Sorry for the slow response.

>
> Please see my comments below.
>
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 HP specific types
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 -----------------
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ordered-list - a set =
of ordered list valid values
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - sure-start
>>
>> Could you explain what "sure-start" does?
>> Is it actually an attribute type of which multiple attributes can exist?
>>
>
> It is an attribute type of which multiple attributes can exist.
> At this moment=C2=A0 Sure-Start reports both the number of audit logs and
> all logs reported by BIOS.
> Sure-Start is exposed directly under
> /sys/class/firmware-attributes/*/attributes/.=C2=A0=C2=A0 Sure Start does=
 not
> provide any authentication.

But what does it mean?
For ordered-list there is a nice explanation.

>
>> Or are there just some global properties that need to be exposed?
>> If it is global it should be directly under
>> /sys/class/firmware-attributes/*/authentication/
>> without needing the type.
>>
>>> +
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 All attribute types support the following values:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 current_value:
>>> @@ -42,16 +48,16 @@ Description:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description of the at <attr>
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 display_name_language_code:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A file that can be read to ob=
tain
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the IETF language tag corresp=
onding to the
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "display_name" of the <attr>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 A file that can be read to obtain
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 the IETF language tag corresponding to the
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "display_name" of the <attr>
>>
>> Are these reindentations and other cleanups intentional?
>>
>> If they are intentional and there are no interactions with your actual
>> patch you could split them into their own patch and submit them
>> separately.
>>
>> This way we wouldn't have to worry about them here anymore.
>
> They were unintentionally.=C2=A0 I will reset them back in the next revie=
w
>>
>> Note:
>> These indentations are different from the newly introduced documentation=
.
>>
>>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 audit_log_entries:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A =
read-only file that returns the events in the log.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Va=
lues are separated using semi-colon (``;``)
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Au=
dit log entry format
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 By=
te 0-15:=C2=A0=C2=A0 Requested Audit Log entry=C2=A0 (Each Audit log is 16 =
bytes)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 By=
te 16-127: Unused
>>
>> How to interpret each log entry?
>>
>
> Byte 0: status
> 1: event id
> 2: msg number
> 3: severity
> 4: source ID
> 5: system state at event
> 6-12 Time stamp
> 13-15: internal buffer data
>
> Application needs to have knowledge of the data provided by BIOS in
> order to interpret the audit log.
>
>> If it is an opaque thing from the firmware that would also be useful to
>> know.
>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 audit_log_entry_count:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A =
read-only file that returns the number of existing audit log events availab=
le to be read.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Va=
lues are separated using comma (``,``)
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [N=
o of entries],[log entry size],[Max number of entries supported]
>>
>> Will log entry size always be 16? Or can it be bigger in the future when
>> more bytes are used?
>> This should be mentioned.
>
> Log entry size is always 16 bytes in size.=C2=A0 The reason is to report =
a
> maximum of 256 entries.=C2=A0 Total 4096 bytes

Does it make sense to expose the number 16 from sysfs if it never can chang=
e anyways?

Note you can also customize the filesize reported in sysfs to expose the ma=
ximum size to be used by userspace.

>>
>> Is audit_log_entry_count ever used without reading audit_log_entries
>> right after?
> Yes. The counter is necessary to determine how many logs are available
> to be read.

I think the cleaner interface would be to have users provide a buffer to re=
ad into and then they check the return value of read().
Users can't trust the count value anyways as it is prone to TOCTOU races.

>
>> If not the count file could be dropped.
>>
>>> +What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys/class/firmware-attributes/*/authentication=
/SPM/status
>>> +Date:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 March 29
>>> +KernelVersion:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.18
>>> +Contact:=C2=A0=C2=A0=C2=A0=C2=A0 "Jorge Lopez" <jorge.lopez2@hp.com>
>>> +Description: 'status' is a read-only file that returns ASCII text repo=
rting
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 the status information.
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 State:=C2=A0 Not Provisioned / Provisioned / Provisioning i=
n progress
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Version:=C2=A0 Major.=C2=A0=C2=A0 Minor
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Feature Bit Mask: <16-bit unsigned number display in hex>
>>
>> How are these bits to be interpreted?
> This information is provided by BIOS.=C2=A0 It is one of those obscure
> values from BIOS.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 SPM Counter: <16-bit unsigned number display in base 10>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Signing Key Public Key Modulus (base64):
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 KEK Public Key Modulus (base64):
>>
>> Is " (base64)" supposed to be part of the contents of the file?
>
> The information reported for Signing Key and KEK public key are
> reported as base64 values.=C2=A0 It applies only to the data and not to t=
he
> file contents.

Put is the file format:
KEK Public Key Modulus (base64): ...
KEK Public Key Modulus: ...

The docs indicate the former.

>>
>>> +
>>> +
>>> +What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys/class/firmware-attributes/*/authentication=
/SPM/statusbin
>>> +Date:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 March 29
>>> +KernelVersion:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.18
>>> +Contact:=C2=A0=C2=A0=C2=A0=C2=A0 "Jorge Lopez" <jorge.lopez2@hp.com>
>>> +Description: 'statusbin' is a read-only file that returns identical st=
atus
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 information reported by 'status' file in binary format.
>>
>> This documentation should contain enough information to understand the
>> files contents.
>>
>>
>> I understand that one WMI call will return all the fields that are part
>> of the "status" and "statusbin" in one response.
>>
>> Are these WMI calls especially expensive or called especially
>> frequently?
>>
>
> Unfortunately the WMI to read the Status binary data is expensive
> hence the reason of only calling once.

Hm, I still dislike the interface, sorry.
What about caching the values in the driver and exposing them via different=
 files?

>> If not I would still argue to split them into one file per field and
>> remove the statusbin file.
>>
>
> Regards,
> > Jorge

