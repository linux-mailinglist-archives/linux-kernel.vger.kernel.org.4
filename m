Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA78967CDFD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjAZOZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjAZOYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:24:36 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A707167E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:23:54 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id t12so2004978lji.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EM8B7vfyD5Py/MB3Opt1I4SCriH6T8vAGD94Cbdc8VI=;
        b=HtAcpybS0NIBL3fotWhYtfxr09jYWtTCVGDxlVw3etdAwsOY2pjTKteiChBYWFp25c
         M5xTsH5caJThm3LbLj7yew7ap5AZqvT6L6DxpUnQolNHQS8N9o82kynnDVByw+X+xHK0
         ZZBNOcSFhzoDKJvyACDcf1mBUrzQ2g3JjXPOtcQaWmmBl7/8obn8xFaSUKleGLMM0tFz
         v3zq82JC5Z76pJsk2JqaJu9LlYqdxUuY8h7ek8A35prxW2OiOkytY7H7lLytjXKmV9R6
         BGePHVznHtAfIvsawcG4By8wGYMpD7WVd65SaxJqX3GTfShCzwyOsRmEF8gzP2Wfq3NH
         i0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EM8B7vfyD5Py/MB3Opt1I4SCriH6T8vAGD94Cbdc8VI=;
        b=QNF+ZQfc8UJ7KZ7L64raTXmG5yoHenQGtHkjsDGq/e8uJjgQfwdtss7tqkG71SLsR8
         +FN5yv6Y7tlRio31y7blh+S1D7vJgo0UUhJOuCKP7AbePh0v+9MIKNfDcY0xdFdoyTyb
         3sG0k9yE1BibXJgWxHJDui6XD+7v5oaYMGrxJGmKT7f7HipZgY2FYXOA01Rq1tOZNVzt
         v1GRSMvumyBum9w2zgsYFGo42zOWCXIswKwoR00yo9eXDeIwaTlerLe07U3Uwjdmll8J
         z2dLgnpZKqls2rd6dMroyJzkuFfKF2Thf3RG42Jvr2zb5OUCVvtx/3OfP/wyLfx3Uj8v
         rOKg==
X-Gm-Message-State: AFqh2kpWO51KGgX2wkFFE7F3HKKmXyVaCY/hXrmIAMzb3gandtWBYU8t
        RbPR+Q8/1n++GDbatJFHt/tw3yzCVKB8dMr5J9I=
X-Google-Smtp-Source: AMrXdXvbWzE9Hn4V0NJC8nCCHk4bKSwM/JdIdOkQ/rCSUe75fkT5Wt2Z/1pvBXsidgROqLCy1NgC8HERP5GUCepO1X4=
X-Received: by 2002:a2e:9b56:0:b0:279:7164:a0aa with SMTP id
 o22-20020a2e9b56000000b002797164a0aamr3380935ljj.318.1674743028156; Thu, 26
 Jan 2023 06:23:48 -0800 (PST)
MIME-Version: 1.0
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com> <Y9Ex3ZUIFxwOBg1n@work-vm> <Y9E5Cg7mreDx737N@redhat.com>
In-Reply-To: <Y9E5Cg7mreDx737N@redhat.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 26 Jan 2023 15:23:34 +0100
Message-ID: <CAFLxGvwHRK3vyXiCv5ELvrDSEkcDgV5c6pNnWgWhcATfp1dedA@mail.gmail.com>
Subject: Re: Linux guest kernel threat model for Confidential Computing
To:     =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 3:22 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
> Any virtual device exposed to the guest that can transfer potentially
> sensitive data needs to have some form of guest controlled encryption
> applied. For disks this is easy with FDE like LUKS, for NICs this is
> already best practice for services by using TLS. Other devices may not
> have good existing options for applying encryption.

I disagree wrt. LUKS. The cryptography behind LUKS protects persistent data
but not transport. If an attacker can observe all IO you better
consult a cryptographer.
LUKS has no concept of session keys or such, so the same disk sector will
always get encrypted with the very same key/iv.

--=20
Thanks,
//richard
