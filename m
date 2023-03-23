Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487976C5ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjCVXns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjCVXn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:43:26 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B03532537
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:43:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b124-20020a253482000000b00b72947f6a54so3299977yba.14
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679528581;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/DUdifk67KM9ArIWEAHj/FFLKRCLqnXjBFIlNA9WLA=;
        b=CfwU/TnHOqKIMZtcm5AVpkQrNDCKbR2jCK73YUnqC6soEdwARNh76usDlcKP/OMn2U
         UDCINQ111/XLDPYV0aBfhCcbMPPY0lAlHAobv8hpRMpI1PcYP8mqn6fis7XvWape3pQ1
         A2nfFkh5AQBuJypQIvfeaapWV/o6t+3Kp3Gz8zsQmgR72z7Sk8FKJD4A28pZw4eUiTW4
         UlfKj31aZL96iwEKYnoJJhE2t2aI8nyxqUKpFvc6h/b4lJWW18Kh56acPLQHSr0CaZi0
         4gPO9Eg/BkrsxqXQzpsx6Dpao7p7N7zNZPZ4hEujhFC31KeyR9Ws3q5/PWerG7qQfcYN
         UV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679528581;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J/DUdifk67KM9ArIWEAHj/FFLKRCLqnXjBFIlNA9WLA=;
        b=f1wKSQWV0GAJXz1vJcVsPSMfyUwDXdmivvdHB5S5lweqW6gmZnDI2pqhGnqNIk/36h
         r04JZk0J9UnVEJS5DkLpurQPH3wF5VCDgiLwIhCU2o1qKkUgkwczE+i0RPjsqcIL040F
         gAqPJQJ/a1O4ZZSRMaA2paAHeOtdwEJRtEkv3EGzgwP7utSw5ZkIQ9hBoJJJI7/jy4vb
         ZOBMJnFNz4Fye6ENcn9dPow3nfiYMcQV9igxcIzmAdk93fKcqdbqY+PaPKUbtqXbtEOY
         Ap/gfnLut/FHgEHvtN5GtmZ9l2jGgRZKze8mumdTFFj7JfckK8i4xAKWNdoUfBH/pPMY
         8xxw==
X-Gm-Message-State: AAQBX9eRw8nIYq5clxkuPtap7Od7o7JfgDdWG4OMuLAzH3OHB5S+sbkE
        sEillzWkjPHhjs6gvN4iTETflDJzJ6s=
X-Google-Smtp-Source: AKy350bwPl3fgCIkcTGctqYwXOP2RogL5Us+NUXeSGJ5mDgZZx9DLrTQheQyTvKz7gvIgafiSnBkCxfkd24=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:a743:0:b0:544:cd0e:2f80 with SMTP id
 e64-20020a81a743000000b00544cd0e2f80mr834457ywh.8.1679528581317; Wed, 22 Mar
 2023 16:43:01 -0700 (PDT)
Date:   Wed, 22 Mar 2023 16:42:59 -0700
In-Reply-To: <c9abb017-0088-b96f-d19a-b25e54ad150d@citrix.com>
Mime-Version: 1.0
References: <20230307023946.14516-1-xin3.li@intel.com> <20230307023946.14516-35-xin3.li@intel.com>
 <ZBs/sSJwr7zdOUsE@google.com> <c9abb017-0088-b96f-d19a-b25e54ad150d@citrix.com>
Message-ID: <ZBuSg+3jJpjA5S5P@google.com>
Subject: Re: [PATCH v5 34/34] KVM: x86/vmx: execute "int $2" to handle NMI in
 NMI caused VM exits when FRED is enabled
From:   Sean Christopherson <seanjc@google.com>
To:     andrew.cooper3@citrix.com
Cc:     Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kvm@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, pbonzini@redhat.com,
        ravi.v.shankar@intel.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023, andrew.cooper3@citrix.com wrote:
> On 22/03/2023 5:49 pm, Sean Christopherson wrote:
> > On Mon, Mar 06, 2023, Xin Li wrote:
> >> Execute "int $2" to handle NMI in NMI caused VM exits when FRED is ena=
bled.
> >>
> >> Like IRET for IDT, ERETS/ERETU are required to end the NMI handler for=
 FRED
> >> to unblock NMI ASAP (w/ bit 28 of CS set).
> > That's "CS" on the stack correct?  Is bit 28 set manually by software, =
or is it
> > set automatically by hardware?  If it's set by hardware, does "int $2" =
actually
> > set the bit since it's not a real NMI?
>=20
> int $2 had better not set it...=EF=BF=BD This is the piece of state that =
is
> intended to cause everything which isn't a real NMI to nest properly
> inside a real NMI.
>=20
> It is supposed to be set on delivery of an NMI, and act as the trigger
> for ERET{U,S} to drop the latch.
>=20
> Software is can set it manually in a FRED-frame in order to explicitly
> unblock NMIs.

Ah, found this in patch 19.  That hunk really belongs in this patch, becaus=
e this
patch is full of magic without that information.

+       /*
+        * VM exits induced by NMIs keep NMI blocked, and we do
+        * "int $2" to reinject the NMI w/ NMI kept being blocked.
+        * However "int $2" doesn't set the nmi bit in the FRED
+        * stack frame, so we explicitly set it to make sure a
+        * later ERETS will unblock NMI immediately.
+        */
+       regs->nmi =3D 1;

Organization aside, this seems to defeat the purpose of _not_ unconditional=
ly
unmasking NMIs on ERET since the kernel assumes any random "int $2" is comi=
ng from
KVM after an NMI VM-Exit.

Eww, and "int $2" doesn't even go directly to fred_exc_nmi(), it trampoline=
s
through fred_sw_interrupt_kernel() first.  Looks like "int $2" from userspa=
ce gets
routed to a #GP, so at least that bit is handled.

I'm not dead set against the proposed approach, but IMO it's not obviously =
better
than a bit of assembly to have a more direct call into the NMI handler.
