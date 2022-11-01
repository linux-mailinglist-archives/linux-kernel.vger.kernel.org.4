Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B18A615600
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiKAXQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiKAXQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:16:25 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD96B62E2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 16:16:23 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id r19so10335813qtx.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 16:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GkHl7wK1an1QAXMDQpgjBBk4lS+ZBqdc8VAUyZTjgP0=;
        b=dhuRXNfV7Pm6NvJ1kFerMA2V6kscG7XlWxL9fOpDN9OqgLfrelrZhg3QcPlMjmlbLD
         KRXL9IUunLs60Zs71pgcxofAKwl2efMntg9XVCYc90nudY9ARJsAG2DzA+0ASL25WIgl
         8exgb0Hyy/5zOebYTexTCseiqoVzdpsG1sJ7FcSiFyswesSdWzrM4KXNEbSV1VF9hOxH
         VNNnmzGyWsIpOSiAyXVLBvx5SM6yeNOduWbmJmU30TP01NYgXUTxqBcBo6sHP2kwv/fV
         v7Ox2T2K5Y6MoidSVQQtiThureUMO+BWMEY9q00hHgaEzb2oYpU0+SoidQIvd8XC2YpE
         leew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GkHl7wK1an1QAXMDQpgjBBk4lS+ZBqdc8VAUyZTjgP0=;
        b=Rgytt1yiQ+d52Eq+JZZ3qAu0UdACSKWR8uP3LxpzMb1wKIdQPCdDvS2kezXK3X/WKV
         wnwgB0DfJlf6war9xDWA659ZpCKmby3YW7g6oh+UzEPaRLoSPjdg2yZk2kwCvBkaHxej
         UNG4Gto58SECxbXC32Heb82LPrsZL7QbuPoUnNRau8Eild4ezhpJHDiwoVwIo1uBhXjj
         zMeskMNn4qVfbUDWwxCslAxxQOpWNzufIY+nh31NPxfWbe4uIVhUd5EgR5lbXOp38yll
         KmHfyYBBYAFOFirb/MXPT2sNvcunVD6UZ9rkyIrvCFsd1oTsVeQOhLAVeNQu9ko5Lnqv
         dt1Q==
X-Gm-Message-State: ACrzQf07DIRLrJiqn8iDB1nzXs1wzkfe4VH7coOxO6dEaIMsckqYhrGL
        nujaSgF3hEz2iFVFbBvD/Po8X0NHdqbMRmNK2XtH6Q==
X-Google-Smtp-Source: AMsMyM73yWk8zwPAc6G2Cbj7Y1wSHOAeQ2sOhe67vX4CePrvvX87hg/WxRk70qfQlvWxbhyDap5tE9dTIDOgNcK1VvY=
X-Received: by 2002:a05:622a:248c:b0:3a5:15f9:57a5 with SMTP id
 cn12-20020a05622a248c00b003a515f957a5mr15278827qtb.48.1667344582751; Tue, 01
 Nov 2022 16:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <CACGdZYJ0_8t1JV2CqW-5B92n2YFNkf6jzi7oVkpsBfNmBGd_VA@mail.gmail.com>
 <CACGdZYLcQeFUdZYkkF1L6XzB=3K-eD37A0znYQbr9U2NbXYeHg@mail.gmail.com>
In-Reply-To: <CACGdZYLcQeFUdZYkkF1L6XzB=3K-eD37A0znYQbr9U2NbXYeHg@mail.gmail.com>
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Tue, 1 Nov 2022 16:16:09 -0700
Message-ID: <CACGdZYLMnfcqwbAXDx+x9vUOMn2cz55oc+8WySBS3J2Xd_q7Lg@mail.gmail.com>
Subject: NULL deref crash in bfq_add_bfqq_busy
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000099b9ad05ec70e938"
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

--00000000000099b9ad05ec70e938
Content-Type: text/plain; charset="UTF-8"

Still poking around here, I think my previous emails were leading me
down a dead end, at least w.r.t. unsafe locking. The one code path I
identified below (blk_bio_list_merge() via __blk_mq_sched_bio_merge())
won't actually get hit since we'll instead call bfq_bio_merge().

The crashes I'm seeing have been in the read side (stacks below)

[160595.656560]  bfq_add_bfqq_busy+0x110/0x1ec
[160595.661142]  bfq_add_request+0x6bc/0x980
[160595.666602]  bfq_insert_request+0x8ec/0x1240
[160595.671762]  bfq_insert_requests+0x58/0x9c
[160595.676420]  blk_mq_sched_insert_request+0x11c/0x198
[160595.682107]  blk_mq_submit_bio+0x270/0x62c
[160595.686759]  __submit_bio_noacct_mq+0xec/0x178
[160595.691926]  submit_bio+0x120/0x184
[160595.695990]  ext4_mpage_readpages+0x77c/0x7c8
[160595.701026]  ext4_readpage+0x60/0xb0
[160595.705158]  filemap_read_page+0x54/0x114
[160595.711961]  filemap_fault+0x228/0x5f4
[160595.716272]  do_read_fault+0xe0/0x1f0
[160595.720487]  do_fault+0x40/0x1c8

or

[28497.344552]  bfq_add_bfqq_busy+0x110/0x1ec
[28497.348787]  bfq_add_request+0x6bc/0x980
[28497.352845]  bfq_insert_request+0x8ec/0x1240
[28497.357265]  bfq_insert_requests+0x58/0x9c
[28497.361503]  blk_mq_sched_insert_requests+0x8c/0x180
[28497.366647]  blk_mq_flush_plug_list+0x15c/0x1e0
[28497.371376]  blk_flush_plug_list+0xf0/0x124
[28497.375877]  blk_finish_plug+0x34/0x48
[28497.379846]  read_pages+0x21c/0x288
[28497.383510]  page_cache_ra_unbounded+0x1f0/0x24c
[28497.388346]  do_page_cache_ra+0x48/0x54
[28497.392388]  do_sync_mmap_readahead+0x190/0x1e0
[28497.397150]  filemap_fault+0x150/0x5f4
[28497.401111]  do_read_fault+0xe0/0x1f0
[28497.404948]  do_fault+0x40/0x1c8

In the crashes I'm looking at, it looks like the inconsistent
bfq_queue is oom_bfqq (where waker_bfqq is NULL, but woken_list_node
is hashed)

I'm looking at bfq_init_rq(), where we set bfqq->waker_bfqq
(potentially to NULL), and only hlist_add_head, no hlist_del_init. It
looks like the logic here is, bfq_get_bfqq_handle_split is supposed to
return a freshly allocated bfq_queue.

However, it can also return oom_bfqq, which may already be on a woken
list - then we proceed to set waker_bfqq without deleting woken_list
node, which can result in the inconsistency seen in the crash. wdyt?

bfqq = bfq_split_bfqq(bic, bfqq);
split = true;

if (!bfqq) {
    bfqq = bfq_get_bfqq_handle_split(bfqd, bic, bio,
                        true, is_sync,
                        NULL);  # This can also return oom_bfqq
    bfqq->waker_bfqq = old_bfqq->waker_bfqq;  # this can be set to null
    bfqq->tentative_waker_bfqq = NULL;


an aside, which looks at the async case, since I'd like to understand
this code better.
---

The call to bfq_split_bfqq() doesn't make sense to me - since for
bfq_get_bfqq_handle_split() et. al. we pass the is_sync parameter, but
bfq_split_bfqq() only ever clears bfqq for sync=true. My understanding
seems like this is intended to be: we decide to split, we call
bfq_split_bfqq() which sets bic->bfqq[is_sync] to NULL, then
bfq_get_bfqq_handle_split() sees that it's null and allocates a brand
new queue. But for async, bfq_split_bfqq will return NULL, but
bic->bfqq[0] was never cleared, so bfq_get_bfqq_handle_split() will
see that, and return that already existing bfqq. We'll then modify the
not-freshly-allocated bfqq.

Should bfq_split_bfqq() here have an is_sync param, and clear the
corresponding bic->bfqq?
---




On Mon, Oct 31, 2022 at 10:05 PM Khazhy Kumykov <khazhy@chromium.org> wrote:
>
> On Mon, Oct 31, 2022 at 9:37 PM Khazhy Kumykov <khazhy@chromium.org> wrote:
> >
> > I'm investigating a NULL deref crash in bfq_add_bfqq_busy(), wherein
> > bfqq->woken_list_node is hashed, but bfqq->waker_bfqq is NULL - which
> > seems inconsistent per my reading of the code.

--00000000000099b9ad05ec70e938
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
EAHF0zc/WzTBCzu4oGMIOM0wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIM7WCkzQ
yPoA+3KfPsXppyMNnYpBYmKmnD8Y2jIWepCEMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTIyMTEwMTIzMTYyM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCVIco0CaNoE1MFIzp0QSCNDNo4
Iv2ZLwQ/l6dHLbFG9AYhuLYaYOBHgV7ngx0iP1IHqQo6e/n+h3kxvZRuhL1eZ7PvzvTU4i/ekXNw
4BPopuEJWTzM9OTAmpWtX1kpGirysx56eBTES6HghgI8izo+UODUXZg4SkgvIJQ+/mancEd+pDhd
6h9PGCHgwwhRVtla2ZPYirJeIuF7pleq4Sjqa9MNs033Blkog0fXtlUSh6vb5IAOJWTIHMPN+r39
osp/i+HPRQJTj3kqIhLWIjw5jAP8/sek2b5g/PALFLAE9kPRk31KtlRhuE304KYBR6QPT01Q5zb/
BzglbBVS3SAw
--00000000000099b9ad05ec70e938--
