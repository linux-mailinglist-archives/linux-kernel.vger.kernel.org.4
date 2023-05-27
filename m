Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFF971337A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 10:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjE0IuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 04:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjE0IuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 04:50:12 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF82EA;
        Sat, 27 May 2023 01:50:09 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2af225e5b4bso15398981fa.3;
        Sat, 27 May 2023 01:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685177408; x=1687769408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yp3RI4Ymku1/YTl+AMFgKSN+8aZ0zpxNMENvg1UhqjA=;
        b=Ptt7JTiP4ZPv/1u0OMFVreaqBUiUkHNLIfEaJu7PkbNYH4ikhlYdpbxoH/NKBHdctE
         CicAamTd0e4BcN+ze9KnxX6/ij6ipLLjFQc2I2HiBPBH+KhbTMljB+NefVJbK2HB32j1
         4cc99aykBdTTklzs3OQlYZWUgdKEkssEL7bkxqEcTMHxC8E8DSNgNj4MBOGyvZoXIlSU
         JIpnihend08kga4/RhGGRfRJtl0BdAjbnpuiGkl5qIgBuFq/eUFCtx2FqsUAbb0WwvMW
         1iR7kfbLTgH3D7Pq8+lB/BQjjKuI1aDFXkWekYsM9MFx8e3xxB3Crl65oYlAewknLAve
         +xNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685177408; x=1687769408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yp3RI4Ymku1/YTl+AMFgKSN+8aZ0zpxNMENvg1UhqjA=;
        b=c3OdZl+z7MV6GlehMLHIRIdV4q7I+IYe7AuztaioRzXtFrPkDfcIvLNUN/zNQ1iH0a
         uj1XwMl5ymT3B2fGSRHz0RYhKzvjrkW0PomWQsi31Uke+UubPUVkTHXboUwYMwaJF+YA
         TB3aTYiVt/QIeDd/23JVwicIUcm4FngHEOUFy8kgf4Q02glfykvR6Hqts004aqA1eUz3
         cm05Zwc50NldBi8KANqSJK+FC0413nkVR+/5fHhlFE/eDUDCzMq0z1phuhY3zsuhskSG
         Q+Z9i2qwY0PK+afTHc3en7zDdwM9ZRtylijQlvPQkd7yAilveqWkaJGDe/Rxpc2n3+Hy
         4ulw==
X-Gm-Message-State: AC+VfDwAC76wUqYWnUXklnHn4Bo4xR7gDYMhYsC/gs9iCykUgjtEecV8
        yNAawbZPW5wtSqgVX8j48Ryu8kyKB8KHMRKyflru03AVkyepuQBY
X-Google-Smtp-Source: ACHHUZ6QkiPpv5AuB1/46USO8iSC4c3midYAAHwtmaIdo1azEAfjDclNb/+7inM/jy7obHUTC44tV5lDNXm1AV/xOhA=
X-Received: by 2002:a2e:7e04:0:b0:2ac:7e64:ef8 with SMTP id
 z4-20020a2e7e04000000b002ac7e640ef8mr1778807ljc.16.1685177407243; Sat, 27 May
 2023 01:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <202305250056.oZhsJmdD-lkp@intel.com> <DM4PR21MB344103E6766B9D586C0D11B1E441A@DM4PR21MB3441.namprd21.prod.outlook.com>
 <CAH2r5mteP0kHJN8SJzhU60q+TreP3AaMhVntEuXBiLQb49mBhw@mail.gmail.com>
In-Reply-To: <CAH2r5mteP0kHJN8SJzhU60q+TreP3AaMhVntEuXBiLQb49mBhw@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 27 May 2023 03:49:55 -0500
Message-ID: <CAH2r5mujTOvAdu2uu=ypRA4ZUPjcMUdefF3b59WMwoUvJrDxRg@mail.gmail.com>
Subject: Re: [EXTERNAL] [samba-ksmbd:for-next 4/7] fs/smb/client/ioctl.c:324:17:
 warning: variable 'caps' set but not used
To:     CIFS <linux-cifs@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000be618905fca8f028"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000be618905fca8f028
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Fix attached:

Fix trivial unused variable warning (when SMB1 support disabled)

"ioctl.c:324:17: warning: variable 'caps' set but not used
[-Wunused-but-set-variable]"

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305250056.oZhsJmdD-lkp@int=
el.com/

> From: kernel test robot <lkp@intel.com>
> Sent: Wednesday, May 24, 2023 7:01:39 AM
> To: Steven French <Steven.French@microsoft.com>
> Cc: oe-kbuild-all@lists.linux.dev <oe-kbuild-all@lists.linux.dev>
> Subject: [EXTERNAL] [samba-ksmbd:for-next 4/7] fs/smb/client/ioctl.c:324:=
17: warning: variable 'caps' set but not used
>
> Hi Steve,
>
> First bad commit (maybe !=3D root cause):
>
> tree:   git://git.samba.org/ksmbd.git for-next
> head:   d58a8a27a7cac75e82383c2a25704bd15b0045d5
> commit: e3adc6b1f0d12b80a7a81fd4f345890a4fb483d6 [4/7] smb: move client a=
nd server files to common directory fs/smb
> config: i386-randconfig-i003-20230524
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> reproduce (this is a W=3D1 build):
>         git remote add samba-ksmbd git://git.samba.org/ksmbd.git
>         git fetch --no-tags samba-ksmbd for-next
>         git checkout e3adc6b1f0d12b80a7a81fd4f345890a4fb483d6
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=3D1 O=3Dbuild_dir ARCH=3Di386 olddefconfig
>         make W=3D1 O=3Dbuild_dir ARCH=3Di386 SHELL=3D/bin/bash fs/smb/cli=
ent/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2F%2Flore.kernel.org%2Foe-kbuild-all%2F202305250056.oZhsJmdD-lkp%40intel.co=
m%2F&data=3D05%7C01%7CSteven.French%40microsoft.com%7Caf0e1ee950724b4eb2ce0=
8db5c78aca3%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C638205445595592058=
%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW=
wiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DmoaptwMZutTbXzs%2F65jeBFL8bJmVzWsj=
oLBeuDAQaMc%3D&reserved=3D0
>
> All warnings (new ones prefixed by >>):
>
>    fs/smb/client/ioctl.c: In function 'cifs_ioctl':
> >> fs/smb/client/ioctl.c:324:17: warning: variable 'caps' set but not use=
d [-Wunused-but-set-variable]
>      324 |         __u64   caps;
>          |                 ^~~~
>
>
> vim +/caps +324 fs/smb/client/ioctl.c
>
> 7ba3d1cdb7988c fs/cifs/ioctl.c Steve French    2021-05-02  312
> f9ddcca4cf7d95 fs/cifs/ioctl.c Steve French    2008-05-15  313  long cifs=
_ioctl(struct file *filep, unsigned int command, unsigned long arg)
> ^1da177e4c3f41 fs/cifs/ioctl.c Linus Torvalds  2005-04-16  314  {
> 496ad9aa8ef448 fs/cifs/ioctl.c Al Viro         2013-01-23  315   struct i=
node *inode =3D file_inode(filep);
> 7e7db86c7e1088 fs/cifs/ioctl.c Steve French    2019-09-19  316   struct s=
mb3_key_debug_info pkey_inf;
> ^1da177e4c3f41 fs/cifs/ioctl.c Linus Torvalds  2005-04-16  317   int rc =
=3D -ENOTTY; /* strange error - but the precedent */
> 6d5786a34d98bf fs/cifs/ioctl.c Pavel Shilovsky 2012-06-20  318   unsigned=
 int xid;
> ba00ba64cf0895 fs/cifs/ioctl.c Jeff Layton     2010-09-20  319   struct c=
ifsFileInfo *pSMBFile =3D filep->private_data;
> 96daf2b09178d8 fs/cifs/ioctl.c Steve French    2011-05-27  320   struct c=
ifs_tcon *tcon;
> a77592a70081ed fs/cifs/ioctl.c Ronnie Sahlberg 2020-07-09  321   struct t=
con_link *tlink;
> d26c2ddd335696 fs/cifs/ioctl.c Steve French    2020-02-06  322   struct c=
ifs_sb_info *cifs_sb;
> f654bac2227adc fs/cifs/ioctl.c Steve French    2005-04-28  323   __u64   =
ExtAttrBits =3D 0;
> 618763958b2291 fs/cifs/ioctl.c Jeff Layton     2010-11-08 @324   __u64   =
caps;
>
> :::::: The code at line 324 was first introduced by commit
> :::::: 618763958b2291a09057dbfa553da6ded93dcfad cifs: make cifs_ioctl han=
dle NULL filp->private_data correctly
>
> :::::: TO: Jeff Layton <jlayton@redhat.com>
> :::::: CC: Steve French <sfrench@us.ibm.com>
>
> --
> 0-DAY CI Kernel Test Service
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.com%2Fintel%2Flkp-tests%2Fwiki&data=3D05%7C01%7CSteven.French%40microsoft=
.com%7Caf0e1ee950724b4eb2ce08db5c78aca3%7C72f988bf86f141af91ab2d7cd011db47%=
7C1%7C0%7C638205445595592058%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLC=
JQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D4S7ypb=
EmVEH0ItLaFq6203nT%2FVUHq%2FI%2B0DPIw8MLllw%3D&reserved=3D0



--=20
Thanks,

Steve

--000000000000be618905fca8f028
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-address-unused-variable-warning.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-address-unused-variable-warning.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_li5r27q50>
X-Attachment-Id: f_li5r27q50

RnJvbSBmZGQ3ZDFmZmY0ZTNiOTdjNDcwNmY0YzBlMDAwYTM4YjEzNGI3YWU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFNhdCwgMjcgTWF5IDIwMjMgMDM6MzM6MjMgLTA1MDAKU3ViamVjdDogW1BBVENIXSBj
aWZzOiBhZGRyZXNzIHVudXNlZCB2YXJpYWJsZSB3YXJuaW5nCgpGaXggdHJpdmlhbCB1bnVzZWQg
dmFyaWFibGUgd2FybmluZyAod2hlbiBTTUIxIHN1cHBvcnQgZGlzYWJsZWQpCgoiaW9jdGwuYzoz
MjQ6MTc6IHdhcm5pbmc6IHZhcmlhYmxlICdjYXBzJyBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNl
ZC1idXQtc2V0LXZhcmlhYmxlXSIKClJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtw
QGludGVsLmNvbT4KQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1rYnVpbGQtYWxs
LzIwMjMwNTI1MDA1Ni5vWmhzSm1kRC1sa3BAaW50ZWwuY29tLwpTaWduZWQtb2ZmLWJ5OiBTdGV2
ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+Ci0tLQogZnMvc21iL2NsaWVudC9pb2N0
bC5jIHwgNiArKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS9mcy9zbWIvY2xpZW50L2lvY3RsLmMgYi9mcy9zbWIvY2xpZW50
L2lvY3RsLmMKaW5kZXggY2IzYmU1OGNkNTVlLi5mZmYwOTJiYmM3YTMgMTAwNjQ0Ci0tLSBhL2Zz
L3NtYi9jbGllbnQvaW9jdGwuYworKysgYi9mcy9zbWIvY2xpZW50L2lvY3RsLmMKQEAgLTMyMSw3
ICszMjEsMTEgQEAgbG9uZyBjaWZzX2lvY3RsKHN0cnVjdCBmaWxlICpmaWxlcCwgdW5zaWduZWQg
aW50IGNvbW1hbmQsIHVuc2lnbmVkIGxvbmcgYXJnKQogCXN0cnVjdCB0Y29uX2xpbmsgKnRsaW5r
OwogCXN0cnVjdCBjaWZzX3NiX2luZm8gKmNpZnNfc2I7CiAJX191NjQJRXh0QXR0ckJpdHMgPSAw
OworI2lmZGVmIENPTkZJR19DSUZTX1BPU0lYCisjaWZkZWYgQ09ORklHX0NJRlNfQUxMT1dfSU5T
RUNVUkVfTEVHQUNZCiAJX191NjQgICBjYXBzOworI2VuZGlmIC8qIENPTkZJR19DSUZTX0FMTE9X
X0lOU0VDVVJFX0xFR0FDWSAqLworI2VuZGlmIC8qIENPTkZJR19DSUZTX1BPU0lYICovCiAKIAl4
aWQgPSBnZXRfeGlkKCk7CiAKQEAgLTMzMSw5ICszMzUsOSBAQCBsb25nIGNpZnNfaW9jdGwoc3Ry
dWN0IGZpbGUgKmZpbGVwLCB1bnNpZ25lZCBpbnQgY29tbWFuZCwgdW5zaWduZWQgbG9uZyBhcmcp
CiAJCQlpZiAocFNNQkZpbGUgPT0gTlVMTCkKIAkJCQlicmVhazsKIAkJCXRjb24gPSB0bGlua190
Y29uKHBTTUJGaWxlLT50bGluayk7Ci0JCQljYXBzID0gbGU2NF90b19jcHUodGNvbi0+ZnNVbml4
SW5mby5DYXBhYmlsaXR5KTsKICNpZmRlZiBDT05GSUdfQ0lGU19QT1NJWAogI2lmZGVmIENPTkZJ
R19DSUZTX0FMTE9XX0lOU0VDVVJFX0xFR0FDWQorCQkJY2FwcyA9IGxlNjRfdG9fY3B1KHRjb24t
PmZzVW5peEluZm8uQ2FwYWJpbGl0eSk7CiAJCQlpZiAoQ0lGU19VTklYX0VYVEFUVFJfQ0FQICYg
Y2FwcykgewogCQkJCV9fdTY0CUV4dEF0dHJNYXNrID0gMDsKIAkJCQlyYyA9IENJRlNHZXRFeHRB
dHRyKHhpZCwgdGNvbiwKLS0gCjIuMzQuMQoK
--000000000000be618905fca8f028--
