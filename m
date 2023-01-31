Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4508F683160
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjAaPW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjAaPWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:22:13 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B42353B08;
        Tue, 31 Jan 2023 07:20:11 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id l4-20020a17090a850400b0023013402671so2694749pjn.5;
        Tue, 31 Jan 2023 07:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BINpfzI37FmubXDbCicBUzweI9/UjZf3V5c6wKLnds=;
        b=krZoGmaRnqVDyYJ7XU3vWJMH5kbybAFhCjzRQWk2kZB3VeCDx4Xx3tV3n1yiWUHOOr
         814/eA/liKoE1pS5VaqQ2sLDkvLOfp1nTpzx+4CUBaTUnW1qotfNkAAAOza0bMOMeEHz
         ZPXq+YD8U4JJgakjxzDLVxvxb+hA/9x3MIg5y8Jmj0zgzbk1gUowjb1Vx7LY2eGj5DvN
         19dAYrbtdssUXndbwOYk7f26EDrQZ0+DeLT6fTxjpkQEC1b0frmc7H96mt+lgJ2Ya/1B
         Kc7d9/oN70IleBIqdDSHq6WwgPAkouxyxxAoY3tGqALvQx6jgbK1gNlnv8xMnm+TcIuJ
         iRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6BINpfzI37FmubXDbCicBUzweI9/UjZf3V5c6wKLnds=;
        b=PYN6WNi8zStVUdzFMVt4FcQM/Hvj0Ac4lXTpC3KNukYjR05TSzkomY4cFiwToxQgPc
         ze8HeaE4P42sRREBnHBlcFb7zupgL0vbhtCW/nd5rM+EDOBNaG7SOjn3QHnCWrDgpQ+n
         80ZG1keCysy8FjATIHFX3A+BXRXPDaOty77BD8qNSKozY7XpmAK9GNkjAVXE2SAdWU9K
         +IuRoqvz1v9AFvcdKziFjYYDqNdhcIS1kxIviCILCe+efxb5Oj2Y4inB5eVjYrzs30xC
         J4LGm5G1RJLN5VnDnpEjoRmShMC5h8Qr9uPNMhsMt0dUXv1WpBepjYQyyRgzMutsDvrF
         a96Q==
X-Gm-Message-State: AO0yUKUk4t8g/RZBVW9cYh1OTnirVEtPtpFkfWlO1UCUKlwwGE73RAzn
        D1e+zHP/AIa4/pbow/y9VijgGiifLLM=
X-Google-Smtp-Source: AK7set80uUmFSGOZLMp0wOxAk4gMm5CvMCBTAUlLTfe2BVHOM9OrrqM29suibFMPqWRrfrVH6wqnTg==
X-Received: by 2002:a17:902:da89:b0:194:6f3b:3aa1 with SMTP id j9-20020a170902da8900b001946f3b3aa1mr15438191plx.55.1675178410502;
        Tue, 31 Jan 2023 07:20:10 -0800 (PST)
Received: from smtpclient.apple ([24.6.25.249])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902ce8800b0018725c2fc46sm9874385plg.303.2023.01.31.07.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 07:20:09 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Shesha Sreenivasamurthy <sheshas@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: Hot ADD using CXL1.1 host
Message-Id: <0D3A81E2-C99A-491D-AB66-FC6005E38667@gmail.com>
Date:   Tue, 31 Jan 2023 07:19:58 -0800
Cc:     linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
To:     Dan Williams <dan.j.williams@intel.com>
X-Mailer: iPhone Mail (20B110)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=EF=BB=BF

On Mon, Jan 30, 2023 at 2:00 PM Dan Williams <dan.j.williams@intel.com> wrot=
e:
>=20
> Hi Shesha, Linux email expectations are to not top post, i.e. respond
> inline, like below:
>=20
> Shesha Sreenivasamurthy wrote:
>> The re-configuration does not reset the device. It does re-program the PC=
Ie
>> DVSEC for CXL Device register (Section 8.1.3 CXL 2.0 spec Pg 258), regist=
er
>> (DVSEC vendor ID 0x1E98, DCSEC ID 0x0).
>> =E2=80=9CSo you need to dynamically recreate the region, especially if yo=
ur step 10
>> above resets the device.=E2=80=9D
>> Do you mean the DAX region ?
>=20
> No, I mean the CXL region.
>=20
>> If so, I can if the system stays up. After a few seconds the system
>> crashes. Can the crash be because of a mismatch between DVSEC
>> information with what kernel was informed by BIOS during boot (Some
>> ACPI tables ?)
>=20
> My concern is that the platform memory decode configuration is not
> prepared for the CXL device to claim more than what was originally
> programmed in the CXL DVSEC range registers. One of the platform
> firmware updates for CXL 2.0 was the creation of the CFMWS (CXL Fixed
> Memory Window Structure) in the ACPI CEDT (CXL Early Discovery Table).
> That structure indicates which platform address ranges decode to which
> CXL host bridges. Those windows are defined in platform specific
> registersi (not enumerated to the OS). If the window is only 8GB then
> the endpoint device can not decode more. You would need to reboot to get
> the BIOS to allocate more host address space for CXL.
>=20
> The expectation for newer platforms is that platform firmware define
> CFMWS such that there is spare capacity in the address map for the OS to
> dynmaically map more CXL.

There seems to be some instability in using DAX. When the system is given al=
l the device memory using efi=3Dnosoftreserve, the stressapptest (https://gi=
thub.com/stressapptest/stressapptest) runs for an extended period of time. H=
owever, when the system is booted without efi=3Dnosoftreserve, and assigned t=
he special purpose memory to system-ram using daxctl, the system crashes aft=
er some time (20-30 mins). Is there any known instabilities when using DAX?
