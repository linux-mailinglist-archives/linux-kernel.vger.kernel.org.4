Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E5761A34F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiKDV0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiKDVZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:25:55 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AC24E416
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 14:25:46 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id o8so4059284qvw.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 14:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k8O5GsUBgGbLqWKGC8yWBj8c7DAZQenWH18ZZzhRmRw=;
        b=cNbVhIGDPevIOB8tMnPaoASSzGjlAvryTJBxGx9tbt3sHwo/M7xadkHNmaDDzhl7fL
         JQayOR6ukMdZyXqTf5Le1UNRCurrpZidjUPwDPXcoNj101QLTe0JjAV5mhW0voGnPr4N
         ZgI+vHrtsmiV42c9dXZUhkgElrqneYcqcllaN/TgB3fUCjMgKtOFZT+3tvMdE53Mbko6
         gtRW2bnOGp25j3S7h1O3wqSpjargkmmUHOOg0CDKaqHoxxiFqgoHolKsWtLz1vGDG3X5
         GMFRavaRpI8PvebxGEKCU4eGvk59hjJgTxxCrd6GcasRt1GytSOQfHHwCU4FEFdBmWPu
         5wwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8O5GsUBgGbLqWKGC8yWBj8c7DAZQenWH18ZZzhRmRw=;
        b=ZP3HZX6mHUPV+FUtpsxs/EFWdxjKGfFzfWAA6wifxjC0Q+wVC7by0RZKLuswKf5Iur
         MLCJqv7RRF3nO4oZ9qdcYNDMb9bhZZKvPjfVUuwMdGSr5ZdT/q5CIpnSuqo0xf4LYMuO
         i7DEJduytB5i92orBQ/LRi14NpcE77LTu/Xfrqd0v/qxYg7W6OkGqFVqfiGPDOgkARpq
         7KXFMvWgZlj8SGP9mKcACiV3rvwnbjIgfwywtsZNZwcWDJsbLalnbOkL1YnehNcfmF1E
         LfoVhXjHZwSfweSAbXNQRVIfz7sBr2hX2wiU7xuzlse4BwHhnGFWbYDB6a8sRSmOnWYK
         P2zw==
X-Gm-Message-State: ACrzQf2LcmJ+tjdlKB+K3k/NT6rrKatUBYB9YHnGpxdqEpPAEaZVyNyq
        OWnpC3FNIf420q4h/xD/uQjJb9ufC2ZH90KaHo/SIgxisV8=
X-Google-Smtp-Source: AMsMyM52IzLN9ehKPsYzpZFyvuc/UJu+X6DKBLnC5R9N4hUuwXnkpmvGa5BMvF7ej+siDgo5LZKXNneqi5QMFgOcs7U=
X-Received: by 2002:a05:6214:f23:b0:4bb:f5db:39b3 with SMTP id
 iw3-20020a0562140f2300b004bbf5db39b3mr27334848qvb.117.1667597145415; Fri, 04
 Nov 2022 14:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221103013937.603626-1-khazhy@google.com> <3c0df3fa-8731-5863-ccc5-f2e60601dbf9@huaweicloud.com>
 <CACGdZYJ0WH+Y9sdchXy30UVTQgPCEo=fW+W9atZh1Ki7Ov4_Gw@mail.gmail.com>
 <f83404b4-84a4-de4e-fa4d-9ce38900d91c@huaweicloud.com> <20221103084744.xsvoul3hjgz7yyo7@quack3>
In-Reply-To: <20221103084744.xsvoul3hjgz7yyo7@quack3>
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Fri, 4 Nov 2022 14:25:32 -0700
Message-ID: <CACGdZYK7xk+CJw9_RKwceXXnREVhgHh9U-OWidnKgYp6B011xQ@mail.gmail.com>
Subject: Re: [RFC PATCH] bfq: fix waker_bfqq inconsistency crash
To:     Jan Kara <jack@suse.cz>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000082b02d05ecabb796"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000082b02d05ecabb796
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 3, 2022 at 1:47 AM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 03-11-22 11:51:15, Yu Kuai wrote:
> > Hi,
> >
> > =E5=9C=A8 2022/11/03 11:05, Khazhy Kumykov =E5=86=99=E9=81=93:
> > > On Wed, Nov 2, 2022 at 7:56 PM Yu Kuai <yukuai1@huaweicloud.com> wrot=
e:
> > > >
> > > > Hi,
> > > >
> > > > =E5=9C=A8 2022/11/03 9:39, Khazhismel Kumykov =E5=86=99=E9=81=93:
> > > > > This fixes crashes in bfq_add_bfqq_busy due to waker_bfqq being N=
ULL,
> > > > > but woken_list_node still being hashed. This would happen when
> > > > > bfq_init_rq() expects a brand new allocated queue to be returned =
from
> > > >
> > > >   From what I see, bfqq->waker_bfqq is updated in bfq_init_rq() onl=
y if
> > > > 'new_queue' is false, but if 'new_queue' is false, the returned 'bf=
qq'
> > > > from bfq_get_bfqq_handle_split() will never be oom_bfqq, so I'm con=
fused
> > > > here...
> > > There's two calls for bfq_get_bfqq_handle_split in this function - th=
e
> > > second one is after the check you mentioned, and is the problematic
> > > one.
> > Yes, thanks for the explanation. Now I understand how the problem
> > triggers.
> >
> > > >
> > > > > bfq_get_bfqq_handle_split() and unconditionally updates waker_bfq=
q
> > > > > without resetting woken_list_node. Since we can always return oom=
_bfqq
> > > > > when attempting to allocate, we cannot assume waker_bfqq starts a=
s NULL.
> > > > > We must either reset woken_list_node, or avoid setting woken_list=
 at all
> > > > > for oom_bfqq - opt to do the former.
> > > >
> > > > Once oom_bfqq is used, I think the io is treated as issued from roo=
t
> > > > group. Hence I don't think it's necessary to set woken_list or
> > > > waker_bfqq for oom_bfqq.
> > > Ack, I was wondering what's right here since, evidently, *someone* ha=
d
> > > already set oom_bfqq->waker_bfqq to *something* (although... maybe it
> > > was an earlier init_rq). But maybe it's better to do nothing if we
> > > *know* it's oom_bfqq.
> >
> > I need to have a check how oom_bfqq get involved with waker_bfqq, and
> > then see if it's reasonable.
> >
> > Probably Jan and Paolo will have better view on this.
>
> Thanks for the CC Kuai and thanks to Khazy for spotting the bug. The
> oom_bfqq is just a fallback bfqq and as such it should be extempted from
> all special handling like waker detection etc. All this stuff is just for
> optimizing performance and when we are OOM, we have far larger troubles
> than to optimize performance.
>
> So how I think we should really fix this is that we extempt oom_bfqq from
> waker detection in bfq_check_waker() by adding:
>
>         bfqq =3D=3D bfqd->oom_bfqq ||
>         bfqd->last_completed_rq_bfq =3D=3D bfqd->oom_bfqq)
>
> to the initial check and then also if bfq_get_bfqq_handle_split() returns
> oom_bfqq we should just skip carrying over the waker information.
Thanks for the tip! I'll send a followup, including your suggestions.

I do have some other questions in this area, if you could help me
understand. Looking again at bfq_init_rq, inside of the !new_queue
section - we call bfq_split_bfqq() to "split" our bfqq, then in the
next line bfq_get_bfqq_handle_split inspects bic_to_bfqq(bic,
is_sync), and if it's NULL, allocates a new queue. However, if we have
an async rq, this call will return the pre-existing async bfqq, as the
call to bfq_split_bfqq() only clears the sync bfqq, ever. The best
understanding I have now is: "bic->bfqq[aync] is never NULL (and we
don't merge async queues) so we'll never reach this !new_queue section
anyways if it's async". Is that accurate?

Thanks,
Khazhy


>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

--00000000000082b02d05ecabb796
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPmwYJKoZIhvcNAQcCoIIPjDCCD4gCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz1MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
IJ8WXTR0Vjyxk58wTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/BAIwADCBmgYIKwYBBQUH
AQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2NhL2dzYXRs
YXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29t
L2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei6x4schvR
zV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBAKD4FWgFMRum92zuAryA
NPkwie9CIiWkuoVdKVSeaDUd+AecUSkvRS5RtSUn261XyqWLRYRJ9DHlOvSPMkvFLYM2Nl7WKyaX
AVjbTyFQVJ/d2k6a8/E+prQGhYdEL6gQ+0pCih+9aPXPs4T6gNfPH18eZvQWHM10laJPvSGiIN5g
hZs2e5193mkiXAOXOYlIBc4e+oGztxLA/TInOfp/edkpWtabE8kNrpN0HrsImfjFO/cj+wvlIIew
qjck+CiS1uR+KsnioC+pQjynP533RsDGZ0H9up7fJ8tdZAjm6nKQv3OlAsrOWfIA5TPV9BE0Qn7v
rLDUK8SloBqzC3egcsYxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9i
YWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENBIDIwMjAC
EAHF0zc/WzTBCzu4oGMIOM0wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAgN6i8p
hAm3x7jOa4xZ20pDd5J8DKMdGwzHKn1X/Ed2MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTIyMTEwNDIxMjU0NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBJB3KrxIgPQLl9cQSZ+yfPMgQa
8rum2WH4xt8MuMrPM/SwPhw3EHJP4mCstwnPcSW64+EPraCBbmmU3T7gfpLNKf+2QnrW2BixnicU
qT6Iu7RAgml/LbpsOETjbf4pvV7GHuVwjpJlSZG+g4/IWdRq5gm9kYROZVoMsXPd6VHEAHUo88kS
5K/D18RCCEEOS3tN48s3JTIkArURTEOapjD0a3Si1oCIi2oWPmkQcBWnBWRPdO5C9HVKlat0d5m2
qvBNgHQzhqXmEZ9AJS16PgyBt/O42yyMz3vxcWNBp9MH07UG50dQGRzmGNUK/yyCUELCObdb+1e+
tXacoov3FslV
--00000000000082b02d05ecabb796--
