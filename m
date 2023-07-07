Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4613674B8C7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjGGVoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGGVoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:44:19 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3932107
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 14:44:17 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5703d12ab9aso29485097b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 14:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688766256; x=1691358256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PK1B4XUSmsVxTGEVpYofcXNkzU0O6/lnVCuUw/ZeQdk=;
        b=LxFbbWM7m6qXuw+EWly1pWO3MyAtoZxWg6TZcpJu3iLzq2QY6sJIpGl0wupo0luYRx
         pVRIys2j3G32VXIbzojRdil2K8tEOVhqGT5OUOeIE2PwQ52jk237oQWfc38OdQNCuGkr
         O3fs4CDLUm4gid4rwtg7kHQU6fErmfotacH+6pwf4wXfYDRN/UcXKS1TBfFSeuz7L8io
         EWFDUqNP4GfIkqaB31XF+P077AoYn46zSTZwCFuxxsRAkWGdRPFPeY0rpjNeM7qVBJ9s
         BlZ5tGh7pfjTerY3fWfBsICMEwxkSP8po8czRPdb2mZscFahYWG3VZ+r0KrnClXG8nmo
         Nwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688766256; x=1691358256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PK1B4XUSmsVxTGEVpYofcXNkzU0O6/lnVCuUw/ZeQdk=;
        b=ZKe8R+y+1zkUFp5CE/P06/0Crkz9+gsWgcoQ2P22OFpWn1igdIzGp27AfRUrxKR6jc
         Jd+ZoO8jxNSbXaCO/GVLWTpa4T97cnZBeSgUlsvKhDVEkEfLNSgbWrJt/BkiBepbs3Ed
         rYPGo4JopHxoGsRXQ9q6Wbm9MceDkPBoGDCG1wNKAIS4+z1qUKvb/D+Xq+4zcsK1tF4J
         KU/RQT/riOUFXHroPcwCOtZI0TY+8KLhHYgYrEqdT0RHcj7mWHJchU1EpUq/RnfyZDCA
         S5x0WTOSwa8rDv4dz5yzdlNJHRKIRJJZbpdYBH8GtC70w5bqGEoqYQvIC/9KCy+AClcy
         FKBw==
X-Gm-Message-State: ABy/qLZ+U2yjReZ98ceqViEb7rIPFLcx6f+tGVa/yvMd0afb+LAWIJ87
        HMa3tMmLRpJ2rSovf6uQTZ8pho0ODUz7Ri6sdc8t
X-Google-Smtp-Source: APBJJlGR43ihrdLgGgsRYf1YCP/AYWhQnuzYXgap5iD4vXhzbx7EYJXYzdJ8PVZfRsiuJT0N3fBYjkJYeCWWKTttST4=
X-Received: by 2002:a0d:d64b:0:b0:579:ed5c:2d10 with SMTP id
 y72-20020a0dd64b000000b00579ed5c2d10mr5867478ywd.30.1688766256372; Fri, 07
 Jul 2023 14:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230610075738.3273764-2-roberto.sassu@huaweicloud.com>
 <1c8c612d99e202a61e6a6ecf50d4cace.paul@paul-moore.com> <a28c8fce-741b-e088-af5e-8a83daa7e25d@schaufler-ca.com>
In-Reply-To: <a28c8fce-741b-e088-af5e-8a83daa7e25d@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 7 Jul 2023 17:44:05 -0400
Message-ID: <CAHC9VhSNqzVpHcDw59a2CznaME1078SJWuEcqJx=R5PQgSjTDg@mail.gmail.com>
Subject: Re: [PATCH v12 1/4] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 7, 2023 at 12:54=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 7/6/2023 6:43 PM, Paul Moore wrote:
> > On Jun 10, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> >> Currently, the LSM infrastructure supports only one LSM providing an x=
attr
> >> and EVM calculating the HMAC on that xattr, plus other inode metadata.
> >>
> >> Allow all LSMs to provide one or multiple xattrs, by extending the sec=
urity
> >> blob reservation mechanism. Introduce the new lbs_xattr_count field of=
 the
> >> lsm_blob_sizes structure, so that each LSM can specify how many xattrs=
 it
> >> needs, and the LSM infrastructure knows how many xattr slots it should
> >> allocate.
> >>
> >> Modify the inode_init_security hook definition, by passing the full
> >> xattr array allocated in security_inode_init_security(), and the curre=
nt
> >> number of xattr slots in that array filled by LSMs. The first paramete=
r
> >> would allow EVM to access and calculate the HMAC on xattrs supplied by
> >> other LSMs, the second to not leave gaps in the xattr array, when an L=
SM
> >> requested but did not provide xattrs (e.g. if it is not initialized).
> >>
> >> Introduce lsm_get_xattr_slot(), which LSMs can call as many times as t=
he
> >> number specified in the lbs_xattr_count field of the lsm_blob_sizes
> >> structure. During each call, lsm_get_xattr_slot() increments the numbe=
r of
> >> filled xattrs, so that at the next invocation it returns the next xatt=
r
> >> slot to fill.
> >>
> >> Cleanup security_inode_init_security(). Unify the !initxattrs and
> >> initxattrs case by simply not allocating the new_xattrs array in the
> >> former. Update the documentation to reflect the changes, and fix the
> >> description of the xattr name, as it is not allocated anymore.
> >>
> >> Adapt both SELinux and Smack to use the new definition of the
> >> inode_init_security hook, and to call lsm_get_xattr_slot() to obtain a=
nd
> >> fill the reserved slots in the xattr array.
> >>
> >> Move the xattr->name assignment after the xattr->value one, so that it=
 is
> >> done only in case of successful memory allocation.
> >>
> >> Finally, change the default return value of the inode_init_security ho=
ok
> >> from zero to -EOPNOTSUPP, so that BPF LSM correctly follows the hook
> >> conventions.
> >>
> >> Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
> >> Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archlin=
ux/
> >> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> >> ---
> >>  include/linux/lsm_hook_defs.h |  6 +--
> >>  include/linux/lsm_hooks.h     | 20 ++++++++++
> >>  security/security.c           | 71 +++++++++++++++++++++++-----------=
-
> >>  security/selinux/hooks.c      | 17 +++++----
> >>  security/smack/smack_lsm.c    | 25 ++++++------
> >>  5 files changed, 92 insertions(+), 47 deletions(-)
> > Two *very* small suggestions below, but I can make those during the
> > merge if you are okay with that Roberto?
> >
> > I'm also going to assume that Casey is okay with the Smack portion of
> > this patchset?  It looks fine to me, and considering his ACK on the
> > other Smack patch in this patchset I'm assuming he is okay with this
> > one as well ... ?
>
> Yes, please feel free to add my Acked-by as needed.

Done.  Thanks Casey.

--=20
paul-moore.com
