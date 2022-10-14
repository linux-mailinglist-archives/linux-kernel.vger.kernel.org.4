Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493D15FF441
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 21:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJNT63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 15:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJNT61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 15:58:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1E41D0D75;
        Fri, 14 Oct 2022 12:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665777487;
        bh=1Liwd8ZbCrocRKAWWRbi9j0+CfT3XqraqowX8PdsdaM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=bcOD2fBAdkwQtcF9rvQD29RXNXyaGP610W4P7dt0rrYLF0c2w7YqkkF/Kwkb7ybPQ
         kMo+XM3zxILoVfC1Z2olTUNGfN5HmGrQlYlf9MWWwj6rXEGW/0tM4QEe91oG6q1suz
         S86oUA9rGadH/d8w1DeS+eOOXlbMH+UwP/V9POuE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.1.1.24] ([217.61.200.164]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV67y-1ocJGj0jVm-00S7y8; Fri, 14
 Oct 2022 21:58:07 +0200
Message-ID: <0259a530-32af-f6be-b2e5-fcfbda80a052@gmx.de>
Date:   Fri, 14 Oct 2022 21:58:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: Possible regression: unable to mount CIFS 1.0 shares from older
 machines since 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c
To:     Steve French <smfrench@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Davyd McColl <davydm@gmail.com>,
        "lsahlber@redhat.com" <lsahlber@redhat.com>,
        "stfrench@microsoft.com" <stfrench@microsoft.com>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <D58238A4-F04E-458E-AB05-4A74235B2C65@getmailspring.com>
 <ff982786-4033-7450-c10c-8ce71c28d6eb@leemhuis.info>
 <CAH2r5mtE-EjNbF3OhCLmbGQFMbJgRZphQHS+hHLBiWRJPEBqKA@mail.gmail.com>
From:   Carsten Langer <carsten.langer@gmx.de>
In-Reply-To: <CAH2r5mtE-EjNbF3OhCLmbGQFMbJgRZphQHS+hHLBiWRJPEBqKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:padXh2RnjollxFDOOtlrXsmY6HvQANRPS2yC3548meSi73n8W9t
 MfiI3oLEAWXBa9bXZPTEWAD5/xixcPcjJw/e927cNNgXjg4o6ZR7qc7UxEaT1bGkKwJr1x/
 mk9oaWA5Z2WkxXQ7xmUD8WUSfs1sBmoZ9u6mw/Vz+JTRmzB7aJbVCycI4ybLYiWMYrdoCz6
 WtubqOKuopzDeEAkdTlZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fgKoRaNZ/HI=:31OUKn8OUU6sjWVFJKwwxi
 ClCpNfUaRn8Rec54WYqSyq8yq3Y+qCpTwhSELn3MvN+w+ZHKqGEmqbGWTzkLhZEssDrJswHHN
 mWTCS+b+xaEFI4L9rQaFan+02LgMo3nXgHeh5qK8fYU5Lz6FsPfegdFl90sIDHYtXidq9Muty
 QGj9oTEvM+q2wz2MzbACEwvrGIhhQRDkAF8DJoQfhyiKaHISqGpI+0wLOyRX347fwtK0Xj3wJ
 o7TKGRr4RNhrwoCOvNYeecwsQ4WGeTABrOCx1lwP+BVWqfvK9Jix43FEx3eBLbks4urWlyvlI
 yCXzmvBHeqoT3Q/Yxg6yMZLKTiXU/1op9p2gkQLa4MJxjZx17guGkt8Flgsibho2Y9SECqfLS
 yiDl6JIv+lZPvkgkkimD8d80wtqk98eXGlUGaOyKxYJ3/HxImrsUzShzC4X8RAtdxO4vp1pxh
 EN78ZmlirX0XEORmjA4jL3gL4dvMgazbP4WFO7ayhbHc3tIEx+7bafkY7AYp/YYI5JuN2fviN
 oNU3Ni2AOu0nlbyb84+v4Qt4o983BZlrbP54jOon8EjJFeud67TFd0DRbuEMOVIkXbFAuajBd
 p9bv3zZRzPCujrr2ldSQPw+nnk0nTb1qh7zQOskhqcRWloqnVOK547/fSxGuBHfJU1Cnf7cm2
 CswkHDoxznOzZECsjVTu38avQKiKHolPP1TuAtgRiCsZ5kGnXotBk1xmDb70sZGz0JpvwEuSb
 h7unRK2vTQIdJd7IPNarqFausuNAQTSRrf3fnm29zEshQ7X7aVbFl0t9hORMvfsitugH7U0XF
 dZLv8AnywwgKduJ8g+zkoK1exudAbv9rwXejrbGFxxOIVVU6ow8vB0Ark+S+XUTJ9Wb0sf6eW
 zaZnHXs55BxQsFkPRp82EzkMDVV729/u8tFrOXUvKyyeY+3/6KKw2gq6b4luZbpahIB9bSfpG
 8/wsgAJeIWIvZ9/5H1+VafbXFvjGGewyjQIUBCfyIG5N44LrOlh7SNCvy4AMVbYqKlbRMfbBZ
 NjStvk4Iqt9wC/1LTTYl0JOxYLOYTA/SeSnXK7Jb18EDxuv0JCu6Baa6m5ZdgRQNZHByslCFV
 0x4JHo+POtzt2+IJiMLGlWPxMss4SglD/Nt5UToLWVq+V53rys/teqnugAzHZ8Uqo40aITa1e
 xrzn3KZohsVnmIvm6E/vY8DVrFIhKfErkBu1Zaq02EAchz2xV7ls4bqvzRrMnsdDCTpkqUs2l
 IWozvKXznKzmmT5DeXGwuTTx84SlViPQjEEcrIohweXMinjppSfdzg3cSQnAqQMAAbN/3W5xb
 3pzSNuq8aT+NFaU9DOkQuAkf1EhOxzfSr3MDB9XCPr2iSwnxKRw6Lyl0R/R9brbJfSlRDqLFI
 LPv+JfxL5HiI6RGmqSbigQFmPH8TigOrLD3OcRxUDY7+nUxZtRwVH31c7RAeyruqpiNjtilY5
 TBikiE1iSDmbKnartTYjw5ugdePvh128Bbzk8UqMwSm4hq/IZIhJtx7ZU71grfWiN61addGPh
 UwHvV+GNGjJzoqj7fQbVvqEGk/7SUDeB6NtG81S/MQVuM
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > We have been looking to see if we could setup some VMs for something
 > that old, and we are willing to test against it if it could
 > realistically be setup, but it has been harder than expected. Ronnie
 > had some ideas and we are willing to experiment more but realistically
 > it is very hard to deal with 'legacy museum style' unless we have some
 > VMs available for old systems.
 >
 > Feel free to contact Ronnie and me or Shyam etc (offline if easier) if
 > you have ideas on how to setup something like this.=C2=A0=C2=A0 We don'=
t want to
 > be encouraging SMB1, but certainly not NTLMv1 auth with SMB1 given its
 > security weaknesses (especially given the particular uses hackers have
 > made of 25+ year old NTLMv1 weaknesses).

I would be willing to try to set up a VM for testing.

The issue was further discussed in
https://bugzilla.kernel.org/show_bug.cgi?id=3D215375
I think we could split the topic. The part important for me and others
affected
by this bug is that this regression introduced a protocol violation of
the SMB1
protocol, even for the case where users want to use SMB1 in guest mode,
i.e. without any authentication. At least in this case IMHO we do not need
to discuss NTLMv1 etc., but just make sure that the SMB1 protocol is
again correctly
followed for the case that no user/password is needed. That is what the
proposed patch is
about.

Thus my idea would be to set up an old-enough Samba server providing the
SMB1 protocol
(just) for guest mode, without user/password. If I could then prove that
without patch
the error against that VM occurs and with the patch it works fine, would
that be enough?

But I wonder what you understand by VM? A VirtualBox OVA file? Vmware?
Some Dockerfile
to create an image?
And as this will be a test against a simulated server in a network, are
there standard
requirements how the network is set up between test system and the VM?

- Carsten
