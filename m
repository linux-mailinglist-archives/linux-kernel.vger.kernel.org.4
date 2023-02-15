Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F60F69778A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbjBOHrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjBOHrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:47:32 -0500
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Feb 2023 23:47:30 PST
Received: from smtpdh17-2.aruba.it (smtpdh17-2.aruba.it [62.149.155.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8222FBB9E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:47:30 -0800 (PST)
Received: from [172.18.100.99] ([109.238.20.116])
        by Aruba Outgoing Smtp  with ESMTPSA
        id SCUjpuOdPD88OSCUjpGWR4; Wed, 15 Feb 2023 08:46:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1676447186; bh=Au9I1na0C0jJNQFDem5w6Inesr0ehTSts1PUEYBd1Is=;
        h=Content-Type:Date:MIME-Version:Subject:To:From;
        b=bm071jtxn+co9pMOI24RIkGAoF46PvkBiGYTCrDHvLXBoOuWHdDnucPf9jdKHsTxF
         R9DLf1Y8Q0kEKnu0lBNTx2zNN4/K7eKnRrwmsoGIfJy75tKV0dcze6BZ3x6QUtsvIr
         M8t4k7zCsWw9+/KPBbL3yYUVUE4l0XG3UfMdauAXQ2fh83wdJe47Xz6ak/it3T11Qi
         Jwx8zVDuqbsDXbILOZdEKqRIXJtjquELcWjXIKSvkYLpYLO6qJMvck4YAxBYk8YLfC
         RHjSKGKPmfYU3GOi5EcCoXHj80bTOJ9FIg+qGMIowcqmvMgX5H4h5t0m6QM2xDpU/A
         hETUBwj3EsfYQ==
Content-Type: multipart/mixed; boundary="------------NfS1SN1AwFm9LJ0s9gng5oM3"
Message-ID: <f8a97493-a5ab-565f-825a-dd0a508f2b66@enneenne.com>
Date:   Wed, 15 Feb 2023 08:46:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: PPS functionality for Intel Timed I/O
To:     "N, Pandith" <pandith.n@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "Gross, Mark" <mark.gross@intel.com>
References: <BYAPR11MB3240A86B426158623DB9983EE1D39@BYAPR11MB3240.namprd11.prod.outlook.com>
 <fa3f1765-eb59-bf69-7f7b-14621caef6ea@enneenne.com>
 <BYAPR11MB3240801F21598EEFAEA79605E1D39@BYAPR11MB3240.namprd11.prod.outlook.com>
 <1e02cc71-baee-1e75-9160-062d563af795@enneenne.com>
 <BYAPR11MB32408E2D9758BD01EC65FB49E1DA9@BYAPR11MB3240.namprd11.prod.outlook.com>
 <f2788a74-19f8-8992-5b92-427c7b2a27ab@enneenne.com>
 <BYAPR11MB3240C6789B4C04F3BDAE34D5E1A39@BYAPR11MB3240.namprd11.prod.outlook.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <BYAPR11MB3240C6789B4C04F3BDAE34D5E1A39@BYAPR11MB3240.namprd11.prod.outlook.com>
X-CMAE-Envelope: MS4xfJIjLjfpJL2emIU+LKnjMrRSSniOVDkHwYIxBgieB67B3raHNDOgTyCtJi9LjoV4ZMmhn+Si86sq3Z7ExkO/wIiqAiW/+bRCUkOz0edr7IG1pZJYxKj/
 2WmwYzxBkcAPLMPYHe85Px5TdrK8m095AGcnj4P1xXHQVs7xSa4V4fw3ZAJUsKMcHUv6BrwZm3/aJf3VpXmWZHU1yy7qMxgHOrIXwJG1be7SlWAOToC0x5TR
 SgHIrX5Rht7znQRRNGYzEWJ03U/sU+tPkazdvH8FHj3viXf3ye+UDDQMARuuqjm93a9MWFSu8xNwW1iqbiASNHjXykh278dmPKFaql0kmsdUpq6u548jHN+T
 mfSvilnRJCkVeXHmjIxtJb5jB1wOnLQO/SdTfLAxsHhNT2mDpwFPb+6/F4RJIQHZkhXU6/VIrKgaOHbamDHPr//7iFoktl3QzdEpH4JF8cIrRdTUH7s=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------NfS1SN1AwFm9LJ0s9gng5oM3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/02/23 08:09, N, Pandith wrote:
> Hi Rodolfo,

Hello.

>> -----Original Message-----
>> From: Rodolfo Giometti <giometti@enneenne.com>
>> Sent: Monday, February 6, 2023 4:17 PM
>> To: N, Pandith <pandith.n@intel.com>
>> Cc: linux-kernel@vger.kernel.org; Sangannavar, Mallikarjunappa
>> <mallikarjunappa.sangannavar@intel.com>; D, Lakshmi Sowjanya
>> <lakshmi.sowjanya.d@intel.com>; T R, Thejesh Reddy
>> <thejesh.reddy.t.r@intel.com>; Hall, Christopher S
>> <christopher.s.hall@intel.com>
>> Subject: Re: PPS functionality for Intel Timed I/O

[snip]

>> Mmm... I'm not sure this is correct since PPS generators should generate
>> their pulses according to system clock and not according to their internal
>> clocks even if they are synced with the system clock.
>>
> Timed I/O and system time are both driven by the *same* hardware clock.
> Timed I/O is a high precision device (nanoseconds), able to output pulses.
> The driver gets the system time and schedules output
> at target_time in the future.

OK, in this case it would be OK. Please put an appropriate note within the 
generator's code and a detailed one within Documentation/driver-api/pps.rst.

Regarding Documentation/driver-api/pps.rst let me suggest you to prose a 
separate patch to rewrite the Generators section in such a way you easily can 
add your solution at the end. A possible example is attached but feel free to 
rewrite it according to your needs.

> struct timespec64 current_time;
> current_time = ktime_get_real_ts64(&current_time);
> 
> target_time = current_time + offset_time;
> cycles = translate_system_time_to_clock_cycles(target_time);
> /* Translate function is developed as part of this driver development */
> 
> /* Schedule pulse at target_time */
> write_timedio_reg(TIMEDIO_TRIGGER, cycles);
> 
> The output always triggers with ~20 ns precision.
> It's not affected by system load or no need for drivers to disable interrupts for longer durations.
> With this driver proposal, Intel Timed I/O as PPS generator will be useful in IoT and server applications.

Great! Please also add these notes to the final Documentation.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

--------------NfS1SN1AwFm9LJ0s9gng5oM3
Content-Type: text/x-patch; charset=UTF-8; name="pps_rst_doc_proposal.patch"
Content-Disposition: attachment; filename="pps_rst_doc_proposal.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9wcHMucnN0IGIvRG9jdW1l
bnRhdGlvbi9kcml2ZXItYXBpL3Bwcy5yc3QKaW5kZXggMmQ2Yjk5NzY2ZWU4Li5lMjUwMzE4
NDVlYzYgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9wcHMucnN0Cisr
KyBiL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9wcHMucnN0CkBAIC0yMDAsMTEgKzIwMCwx
NyBAQCBHZW5lcmF0b3JzCiAKIFNvbWV0aW1lcyBvbmUgbmVlZHMgdG8gYmUgYWJsZSBub3Qg
b25seSB0byBjYXRjaCBQUFMgc2lnbmFscyBidXQgdG8gcHJvZHVjZQogdGhlbSBhbHNvLiBG
b3IgZXhhbXBsZSwgcnVubmluZyBhIGRpc3RyaWJ1dGVkIHNpbXVsYXRpb24sIHdoaWNoIHJl
cXVpcmVzCi1jb21wdXRlcnMnIGNsb2NrIHRvIGJlIHN5bmNocm9uaXplZCB2ZXJ5IHRpZ2h0
bHkuIE9uZSB3YXkgdG8gZG8gdGhpcyBpcyB0bwotaW52ZW50IHNvbWUgY29tcGxpY2F0ZWQg
aGFyZHdhcmUgc29sdXRpb25zIGJ1dCBpdCBtYXkgYmUgbmVpdGhlciBuZWNlc3NhcnkKLW5v
ciBhZmZvcmRhYmxlLiBUaGUgY2hlYXAgd2F5IGlzIHRvIGxvYWQgYSBQUFMgZ2VuZXJhdG9y
IG9uIG9uZSBvZiB0aGUKLWNvbXB1dGVycyAobWFzdGVyKSBhbmQgUFBTIGNsaWVudHMgb24g
b3RoZXJzIChzbGF2ZXMpLCBhbmQgdXNlIHZlcnkgc2ltcGxlCi1jYWJsZXMgdG8gZGVsaXZl
ciBzaWduYWxzIHVzaW5nIHBhcmFsbGVsIHBvcnRzLCBmb3IgZXhhbXBsZS4KK2NvbXB1dGVy
cycgY2xvY2sgdG8gYmUgc3luY2hyb25pemVkIHZlcnkgdGlnaHRseS4KKworCitQYXJhbGxl
bCBwb3J0IGdlbmVyYXRvcgorLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCisKK09uZSB3YXkg
dG8gZG8gdGhpcyBpcyB0byBpbnZlbnQgc29tZSBjb21wbGljYXRlZCBoYXJkd2FyZSBzb2x1
dGlvbnMKK2J1dCBpdCBtYXkgYmUgbmVpdGhlciBuZWNlc3Nhcnkgbm9yIGFmZm9yZGFibGUu
IFRoZSBjaGVhcCB3YXkgaXMgdG8KK2xvYWQgYSBQUFMgZ2VuZXJhdG9yIG9uIG9uZSBvZiB0
aGUgY29tcHV0ZXJzIChtYXN0ZXIpIGFuZCBQUFMgY2xpZW50cworb24gb3RoZXJzIChzbGF2
ZXMpLCBhbmQgdXNlIHZlcnkgc2ltcGxlIGNhYmxlcyB0byBkZWxpdmVyIHNpZ25hbHMKK3Vz
aW5nIHBhcmFsbGVsIHBvcnRzLCBmb3IgZXhhbXBsZS4KIAogUGFyYWxsZWwgcG9ydCBjYWJs
ZSBwaW5vdXQ6OgogCg==

--------------NfS1SN1AwFm9LJ0s9gng5oM3--
