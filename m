Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49A060A576
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 14:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbiJXMYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 08:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiJXMWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 08:22:53 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBD21157
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:59:22 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id e15so7486166iof.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lmDXjWDbzeRAAinxIUP48fheIu9ywPgXIW0o1gwdOzo=;
        b=XevXOugMqRF1oIpGbTIWwAaffV0qJS+9xjgf8qkbi4//DM9GGNtIcE/LtU6LK/Ac/a
         Sqd2k/eM+v3wTCG9c8r8FgdpLx7ZccbOrE0u605lMJegkkLAheMzLSqTep/yq6KyzbhW
         9AIXYR57KwIZGUp74mrEZ2GzAQYDAJPFMbSFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmDXjWDbzeRAAinxIUP48fheIu9ywPgXIW0o1gwdOzo=;
        b=GPj770hnZ7y+eHQ9q8vwSsWlRF380SKZOQTesnN+M/QoTying4y/Lu8qGSADB2zsgk
         cZ/xWRc3RrXgKsopbuolHcPZel1upCWQb4iY3iOkWP+5y//1Q22WN2qVZ0NOUepPmLy4
         LDK1QniAeRa3zVcnQRhSGVNt4Byg9dPcXgkSGKaWSWbdlGcNcbeoMKt1BEM8OIz3I9Zn
         BW8lBIBD95xLorbFhHMdVDHnLLZaTAYkixl+BR5T4X1AP70aHdqnqeovwjm9kw2C6Lai
         fXrWx3zVk9ycUdrlfAv7SJqKqcut4NR+BTTbdWzr08nfxHjv2NeQfYiB4l4+CTKW0eyX
         gmuA==
X-Gm-Message-State: ACrzQf0L+njLta8d/0fwVuvnCONIHaJNwrYflZUl1Ql8iY9uQJxtmA8l
        thKNm6/nTJlzvdFMeZdoiLzBPQmuf4nV+l/2CfRq1w==
X-Google-Smtp-Source: AMsMyM679MO3yAC93JYcpIzYICFZTxmBQ36woWKdu4O0Q6zf7hvaFvC+P16x3sbIZl751nVIrjtULTkWp4W2oXpZTG8=
X-Received: by 2002:a05:6638:272c:b0:363:e601:cb62 with SMTP id
 m44-20020a056638272c00b00363e601cb62mr21164710jav.284.1666612616150; Mon, 24
 Oct 2022 04:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <Y1JkuKTjVYrOWbvm@eldamar.lan> <85ad4508-b979-c792-e92b-01bc16260dec@acm.org>
In-Reply-To: <85ad4508-b979-c792-e92b-01bc16260dec@acm.org>
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Date:   Mon, 24 Oct 2022 17:26:44 +0530
Message-ID: <CAK=zhgr=MYn=-mrz3gKUFoXG_+EQ796bHEWSdK88o1Aqamby7g@mail.gmail.com>
Subject: Re: Report in downstream Debian: mpt3sas broken with xen dom0 with
 update to 5.10.149 in 5.10.y.
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        sathya.prakash@broadcom.com, suganath-prabu.subramani@broadcom.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        adi@kriegisch.at
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000fb5e5b05ebc67ce1"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000fb5e5b05ebc67ce1
Content-Type: text/plain; charset="UTF-8"

On Sun, Oct 23, 2022 at 6:57 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 10/21/22 02:22, Salvatore Bonaccorso wrote:
> > We got the following report in Debian after an update from 5.10.140 to
> > the current 5.10.149. Full quoting below (from
> > https://bugs.debian.org/1022126). Does this ring some bell about known
> > regressions?
>
> Only three mpt3sas changes are new in v5.10.149 compared to v5.10.140:
> $ git log --format=oneline v5.10.140..v5.10.149
> 2b9aba0c5d58e141e32bb1bb4c7cd91d19f075b8 scsi: mpt3sas: Fix return value check of dma_get_required_mask()
> e7fafef9830c4a01e60f76e3860a9bef0262378d scsi: mpt3sas: Force PCIe scatterlist allocations to be within same 4 GB region
> ea10a652ad2ae2cf3eced6f632a5c98f26727057 scsi: mpt3sas: Fix use-after-free warning
>
> Sreekanth and Suganath, can you help with bisecting this issue? For the
> full report, see also https://lore.kernel.org/linux-scsi/Y1JkuKTjVYrOWbvm@eldamar.lan/.

This issue is getting observed after having the below patch changes,
2b9aba0c5d58e141e32bb1bb4c7cd91d19f075b8 scsi: mpt3sas: Fix return
value check of dma_get_required_mask()

What is happening is that on Xen hypervisor, this
dma_get_required_mask() API always returns a 32 bit DMA mask. I.e. It
says that the minimum DMA mask required to access the host memory is
32 bit and hence mpt3sas driver is setting the DMA mask to 32bit. So,
on a 64 bit machine, if the driver set's the DMA mask to 32 bit then
SWIOTLB's bounce buffer comes into picture during IOs. Since these
bounce buffers are limited in size and hence we observe the IO hang if
the large IOs are issued.

I am not sure whether this API's return value is correct or not in the
Xen environment. If it is correct then I have to modify the driver to
not use this API and directly set the DMA mask to 64 bit if the system
is a 64bit machine.

Thanks,
Sreekanth



>
> Thanks,
>
> Bart.

--000000000000fb5e5b05ebc67ce1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
vZXeqKYupAd0/kWANIYKfeXvBSrhLTL/JLyu02jrKwUQmNeV/csW4n51mmbQyz5VRjLIaM9r93rl
EKIoHplnybLWh6glNdzUbh+wpglCjssypREDVGZjlDD7NS2Q6FUCAwEAAaOCAd0wggHZMA4GA1Ud
DwEB/wQEAwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUu
Z2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggr
BgEFBQcwAYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3
Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4
aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmww
JwYDVR0RBCAwHoEcc3JlZWthbnRoLnJlZGR5QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU90fCF++yKdqz
eSa+l3ox+Xh3bUUwDQYJKoZIhvcNAQELBQADggEBAEdSkxxx3jOPvsTAmqeChWssN7WYUZOhNQu/
+6bxE3/kn9StH6miItK87eIRsO0FFVLDJBnhWz0EGzWEliC68mV8ecDApK5douyO1VfXN8awZZ33
i/RQS2sGbz1vIfPu54rtnwXGoUiXRaSOz0pLy/JRCFyHOj+8GKauKkyrUWiD0j1xPTJ1p8/KOyKd
hPIHLRxnZxqpa2GjCtl3IYjKK8WbWx0NXkszaVTVRIn8e++VyiiH/yFXVyOEQxkZRQZWzTjPE9o/
R31F09e8yABfehc+e00bSP23FKNuA8dwS29RHLpjmd+m5EtbFGD4EUANHzCSTA89S/iWNoaWteab
v6IxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwftyuc
ixn6z19iSQwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFq7l/PC0jHugfQtWux6
CdKsCZRPiFaYvxZKZNy5e5noMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTIyMTAyNDExNTY1NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBIcoRPJF8VgzJC3X0oTVSDPRp1frOubd3wuffU
6EFgkT0cfeucQY8bLVnhEI3v18Lrz/72J+bede6toF4HeXxkuyZFKv6QK2A72RmYtOIwOcjvkutP
UFMJ5ZUXgJi889aHsKmqUuPi+tdd632Ag9ryvdsjcmR7x8GRydXG4xbEUYptSLp2mIEOBZ/Dp+Dj
9p3MrPUungIhuIfCa4VO5jz447ec2ni9xMyEyg6swpad+FuAx9y1v/osKybhBnYUuRZ2hyOAMAtl
W73n34yZ24Q5DBusIfdu6S1hYobYupsKuO53WzoWbGhTkbgjGB8r75iMyrwgyfw3a9UBXfkRmb/f
--000000000000fb5e5b05ebc67ce1--
