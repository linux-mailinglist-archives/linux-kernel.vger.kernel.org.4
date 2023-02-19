Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B20C69BF3A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 09:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjBSIxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 03:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBSIxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 03:53:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E717E3C3A;
        Sun, 19 Feb 2023 00:53:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E49060BCA;
        Sun, 19 Feb 2023 08:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41A4C4339C;
        Sun, 19 Feb 2023 08:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676796807;
        bh=cm1XO+JGD1mM83MkcbYtX0xaXKhxOK/xRQXg6YQuEAE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KK2Lf8IKHyh6LHldozKYiWg8zcZ7a3eTdBCT7w6pC5rxG2lPnlzPhWNibePAfg6kf
         sXsd7e1DZ7d3QtQmYYt3M1sI1ZOBthMHsbxklIwkbPLCHPJl4l9gUrMZJFwL7M68Ea
         4PbkkcPbGLYm/sQNJeGYqkbhUvkbKLAfH2fLuORqGJqjFN0SAirVcZyy3lBmzHJEMH
         L2gP8kpPYFtpkv0YLnZF/lcmVjT3jbgaXiKOtjxg/kf4CO0NkKVOrG7BAw/nm3j44J
         TV80fjNhn770gcN1ae/0q/MM9jsOgevY5xb3May3K9MM8dwWmpLy5BPw4r4yen7ja7
         HlxJCcSWAF7ng==
Received: by mail-oi1-f175.google.com with SMTP id bk33so1636134oib.10;
        Sun, 19 Feb 2023 00:53:27 -0800 (PST)
X-Gm-Message-State: AO0yUKVJXc0RI2vIM55RcYlmKrwayoLs4kfyRnRDaFG42j+KoRFZlyqV
        wVx+nuXBhLtLcH7aM/SnGaHHy2PQHCFoap46JWw=
X-Google-Smtp-Source: AK7set8Ldxt+2AOt6gzKFhLF3u+hKYkEtdHdsDNOiKmsbTnvFOB5ZZOQ9PRD8ksjALvRMeIoOHPMTU9gbUjTFCQtbeU=
X-Received: by 2002:a05:6808:3203:b0:37a:bc9f:afe7 with SMTP id
 cb3-20020a056808320300b0037abc9fafe7mr559487oib.56.1676796806911; Sun, 19 Feb
 2023 00:53:26 -0800 (PST)
MIME-Version: 1.0
References: <20230217202234.32260-1-quic_johmoo@quicinc.com>
 <20230217202234.32260-2-quic_johmoo@quicinc.com> <Y/CJhzSJ5YKvD7my@kroah.com> <Y/CM9JtK0914YUE0@kroah.com>
In-Reply-To: <Y/CM9JtK0914YUE0@kroah.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 19 Feb 2023 17:52:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNASbPi9KgygdZ4XqWEXfK1xunYoWGJwbA2maKuJ=KuyR2Q@mail.gmail.com>
Message-ID: <CAK7LNASbPi9KgygdZ4XqWEXfK1xunYoWGJwbA2maKuJ=KuyR2Q@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/1] check-uapi: Introduce check-uapi.sh
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     John Moon <quic_johmoo@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        kernel-team@android.com, Jordan Crouse <jorcrous@amazon.com>
Content-Type: multipart/mixed; boundary="00000000000009844705f509ae41"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000009844705f509ae41
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 18, 2023 at 5:31 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Feb 18, 2023 at 09:17:12AM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Feb 17, 2023 at 12:22:34PM -0800, John Moon wrote:
> > > While the kernel community has been good at maintaining backwards
> > > compatibility with kernel UAPIs, it would be helpful to have a tool
> > > to check if a patch introduces changes that break backwards
> > > compatibility.
> > >
> > > To that end, introduce check-uapi.sh: a simple shell script that
> > > checks for changes to UAPI headers using libabigail.
> > >
> > > libabigail is "a framework which aims at helping developers and
> > > software distributors to spot some ABI-related issues like interface
> > > incompatibility in ELF shared libraries by performing a static
> > > analysis of the ELF binaries at hand."
> > >
> > > The script uses one of libabigail's tools, "abidiff", to compile the
> > > changed header before and after the patch to detect any changes.
> > >
> > > abidiff "compares the ABI of two shared libraries in ELF format. It
> > > emits a meaningful report describing the differences between the two
> > > ABIs."
> > >
> > > Signed-off-by: John Moon <quic_johmoo@quicinc.com>
> > > ---
> > >  scripts/check-uapi.sh | 245 ++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 245 insertions(+)
> > >  create mode 100755 scripts/check-uapi.sh
> >
> > Ok, this is very cool, thank you so much for doing this.
> >
> > I know Randy Dunlap was also looking into this previously, so I've cc:e=
d
> > him and bounced him the original.
> >
> > I tried this out, and at first glance, this felt like it was just "too
> > fast" in that nothing actually was being tested.  So I manually added a
> > field to a structure I know would break the abi, and:
> >
> >       $ ./scripts/check-uapi.sh
> >       !!! ABI differences detected in include/uapi/linux/usb/ch9.h (com=
pared to file at HEAD^1) !!!
> >
> >           [C] 'struct usb_ctrlrequest' changed:
> >             type size changed from 64 to 72 (in bits)
> >             1 data member insertion:
> >               '__u8 abi_break', at offset 16 (in bits) at ch9.h:216:1
> >             3 data member changes:
> >               '__le16 wValue' offset changed from 16 to 24 (in bits) (b=
y +8 bits)
> >               '__le16 wIndex' offset changed from 32 to 40 (in bits) (b=
y +8 bits)
> >               '__le16 wLength' offset changed from 48 to 56 (in bits) (=
by +8 bits)
> >
> >       0/1 UAPI header file changes are backwards compatible
> >       UAPI header ABI check failed
> >
> > So it worked!
>
> Ok, I take it back, it doesn't seem to work :(
>
> It only "catches" a change from the last commit, but if you have an
> intermediate commit (i.e change something in HEAD^ but not HEAD), it
> does not detect it at all.
>
> And if you give it an old version, it doesn't check that either (hint,
> try passing in a very old kernel version, that returns instantly and
> doesn't actually build anything).
>
> So it's a good first cut as an example, but as it doesn't really work
> correctly yet, we can't take it.  Care to fix it up to work so that it
> can be usable?
>
> thanks,
>
> greg k-h



This tool does not even work with changes in HEAD.

I attached two test-case patches.

This patch does not mention any requirement for
the build host, but neither of them works for me,
on Ubuntu 22.04.

I guess people will find more bad cases
if they use older distros as the build host.
(I know why it does not work, though)




For patch 0001:

$ ./scripts/check-uapi.sh
Couldn't compile current version of UAPI header
include/uapi/linux/cec-funcs.h...
In file included from <command-line>:
/tmp/tmp.gYBwfiWTqX/usr/include/linux/cec-funcs.h.pre: In function
=E2=80=98cec_msg_set_audio_volume_level=E2=80=99:
/tmp/tmp.gYBwfiWTqX/usr/include/linux/cec-funcs.h.pre:1575:23: error:
=E2=80=98CEC_MSG_SET_AUDIO_VOLUME_LEVEL=E2=80=99 undeclared (first use in t=
his
function)
 1575 |         msg->msg[1] =3D CEC_MSG_SET_AUDIO_VOLUME_LEVEL;
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/tmp.gYBwfiWTqX/usr/include/linux/cec-funcs.h.pre:1575:23: note:
each undeclared identifier is reported only once for each function it
appears in
0/1 UAPI header file changes are backwards compatible
UAPI header ABI check failed



For patch 0002:

$ ./scripts/check-uapi.sh
Couldn't compile current version of UAPI header include/uapi/linux/signal.h=
...
In file included from /tmp/tmp.wm5RykUr3y/usr/include/linux/signal.h.pre:5,
                 from <command-line>:
/usr/include/x86_64-linux-gnu/asm/signal.h:103:9: error: unknown type
name =E2=80=98size_t=E2=80=99
  103 |         size_t ss_size;
      |         ^~~~~~
0/1 UAPI header file changes are backwards compatible
UAPI header ABI check failed






BTW, I recommend you to not pick up a patch before having
any reviewer read the code.










--
Best Regards
Masahiro Yamada

--00000000000009844705f509ae41
Content-Type: application/x-patch; 
	name="0001-uapi-linux-cec-funcs.h-add-harmless-change-for-user-.patch"
Content-Disposition: attachment; 
	filename="0001-uapi-linux-cec-funcs.h-add-harmless-change-for-user-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_leb596j00>
X-Attachment-Id: f_leb596j00

RnJvbSBkYmMxY2ZlOGFhZTMzNDU5ZTc4YjA0ZGYyMWE0NjhmODJiZDU2MDYwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3Jn
PgpEYXRlOiBTdW4sIDE5IEZlYiAyMDIzIDE3OjA4OjU2ICswOTAwClN1YmplY3Q6IFtQQVRDSCAx
LzJdIHVhcGkvbGludXgvY2VjLWZ1bmNzLmg6IGFkZCBoYXJtbGVzcyBjaGFuZ2UgZm9yCiB1c2Vy
LXNwYWNlIGludGVyZmFjZQpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxh
aW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKVGhpcyBp
cyBhIHRlc3QtY2FzZSBmb3IgWzFdLgoKVGhpcyBhZGRzIG9uZSBhcHBhcmVudGx5IGhhcm1sZXNz
IG1hY3JvIGRlZmluaXRpb24uCgpTbywgd2UgZXhwZWN0IHNjcmlwdHMvY2hlY2stdWFwaS5zaCB3
aWxsIHBhc3MgYnV0IGl0IGFjdHVhbGx5IGZhaWxzCih1bmxlc3MgeW91IHVzZSB0aGUgdmVyeSBu
ZXcgZGlzdHJvIGFzIHlvdXIgYnVpbGQgaG9zdCkuCgogICQgLi9zY3JpcHRzL2NoZWNrLXVhcGku
c2gKICBDb3VsZG4ndCBjb21waWxlIGN1cnJlbnQgdmVyc2lvbiBvZiBVQVBJIGhlYWRlciBpbmNs
dWRlL3VhcGkvbGludXgvY2VjLWZ1bmNzLmguLi4KICBJbiBmaWxlIGluY2x1ZGVkIGZyb20gPGNv
bW1hbmQtbGluZT46CiAgL3RtcC90bXAuSTg2MUtEZWo1NC91c3IvaW5jbHVkZS9saW51eC9jZWMt
ZnVuY3MuaC5wcmU6IEluIGZ1bmN0aW9uIOKAmGNlY19tc2dfc2V0X2F1ZGlvX3ZvbHVtZV9sZXZl
bOKAmToKICAvdG1wL3RtcC5JODYxS0RlajU0L3Vzci9pbmNsdWRlL2xpbnV4L2NlYy1mdW5jcy5o
LnByZToxNTc1OjIzOiBlcnJvcjog4oCYQ0VDX01TR19TRVRfQVVESU9fVk9MVU1FX0xFVkVM4oCZ
IHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQogICAxNTc1IHwgICAgICAg
ICBtc2ctPm1zZ1sxXSA9IENFQ19NU0dfU0VUX0FVRElPX1ZPTFVNRV9MRVZFTDsKICAgICAgICB8
ICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KICAv
dG1wL3RtcC5JODYxS0RlajU0L3Vzci9pbmNsdWRlL2xpbnV4L2NlYy1mdW5jcy5oLnByZToxNTc1
OjIzOiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBpcyByZXBvcnRlZCBvbmx5IG9u
Y2UgZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbgogIDAvMSBVQVBJIGhlYWRlciBmaWxl
IGNoYW5nZXMgYXJlIGJhY2t3YXJkcyBjb21wYXRpYmxlCiAgVUFQSSBoZWFkZXIgQUJJIGNoZWNr
IGZhaWxlZAoKWzFdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1rYnVpbGQvQ0FLN0xO
QVNmX1JRR002UVl3dlVOK0ZMcS12M2pLNjZQazVqVzlNLXZNMVY0SzB4SDhnQG1haWwuZ21haWwu
Y29tL1QvI20wYTljNDkwZDM0MjU0MTA1NmVkY2U3YTAxMzhiNTI5Zjk5Y2M4OTllCgpTaWduZWQt
b2ZmLWJ5OiBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3JnPgotLS0KIGluY2x1
ZGUvdWFwaS9saW51eC9jZWMtZnVuY3MuaCB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvY2VjLWZ1bmNzLmggYi9p
bmNsdWRlL3VhcGkvbGludXgvY2VjLWZ1bmNzLmgKaW5kZXggZDU4ZmExY2RjYjA4Li41MjRkZDNl
OTViNWMgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9jZWMtZnVuY3MuaAorKysgYi9p
bmNsdWRlL3VhcGkvbGludXgvY2VjLWZ1bmNzLmgKQEAgLTE5NTUsNCArMTk1NSw2IEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCBjZWNfb3BzX2NkY19ocGRfcmVwb3J0X3N0YXRlKGNvbnN0IHN0cnVjdCBj
ZWNfbXNnICptc2csCiAJKmhwZF9lcnJvciA9IG1zZy0+bXNnWzVdICYgMHhmOwogfQogCisjZGVm
aW5lIERVTU1ZX0ZPTyAxCisKICNlbmRpZgotLSAKMi4zNC4xCgo=
--00000000000009844705f509ae41
Content-Type: application/x-patch; 
	name="0002-uapi-linux-signal.h-add-harmless-change-for-user-spa.patch"
Content-Disposition: attachment; 
	filename="0002-uapi-linux-signal.h-add-harmless-change-for-user-spa.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_leb596ja1>
X-Attachment-Id: f_leb596ja1

RnJvbSA2NTMyMGJkOTYyZGQ5MmI5Mzc2ZjBmZGI5M2NlODQzNjRlNmUxMjg5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3Jn
PgpEYXRlOiBTdW4sIDE5IEZlYiAyMDIzIDE3OjExOjEzICswOTAwClN1YmplY3Q6IFtQQVRDSCAy
LzJdIHVhcGkvbGludXgvc2lnbmFsLmg6IGFkZCBoYXJtbGVzcyBjaGFuZ2UgZm9yIHVzZXItc3Bh
Y2UKIGludGVyZmFjZQpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47
IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKVGhpcyBpcyBh
IHRlc3QtY2FzZSBmb3IgWzFdLgoKVGhpcyBhZGRzIG9uZSBhcHBhcmVudGx5IGhhcm1sZXNzIG1h
Y3JvIGRlZmluaXRpb24uCgpTbywgd2UgZXhwZWN0IHNjcmlwdHMvY2hlY2stdWFwaS5zaCB3aWxs
IHBhc3MsIGJ1dCBpdCBhY3R1YWxseSBmYWlscwoodW5sZXNzIHlvdSB1c2UgdGhlIHZlcnkgbmV3
IGRpc3RybyBhcyB5b3VyIGJ1aWxkIGhvc3QpLgoKICAkIC4vc2NyaXB0cy9jaGVjay11YXBpLnNo
CiAgQ291bGRuJ3QgY29tcGlsZSBjdXJyZW50IHZlcnNpb24gb2YgVUFQSSBoZWFkZXIgaW5jbHVk
ZS91YXBpL2xpbnV4L3NpZ25hbC5oLi4uCiAgSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC90bXAvdG1w
LkVpQUM5elM5dWQvdXNyL2luY2x1ZGUvbGludXgvc2lnbmFsLmgucHJlOjUsCiAgICAgICAgICAg
ICAgICAgICBmcm9tIDxjb21tYW5kLWxpbmU+OgogIC91c3IvaW5jbHVkZS94ODZfNjQtbGludXgt
Z251L2FzbS9zaWduYWwuaDoxMDM6OTogZXJyb3I6IHVua25vd24gdHlwZSBuYW1lIOKAmHNpemVf
dOKAmQogICAgMTAzIHwgICAgICAgICBzaXplX3Qgc3Nfc2l6ZTsKICAgICAgICB8ICAgICAgICAg
Xn5+fn5+CiAgMC8xIFVBUEkgaGVhZGVyIGZpbGUgY2hhbmdlcyBhcmUgYmFja3dhcmRzIGNvbXBh
dGlibGUKICBVQVBJIGhlYWRlciBBQkkgY2hlY2sgZmFpbGVkCgpbMV06IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LWtidWlsZC9DQUs3TE5BU2ZfUlFHTTZRWXd2VU4rRkxxLXYzaks2NlBr
NWpXOU0tdk0xVjRLMHhIOGdAbWFpbC5nbWFpbC5jb20vVC8jbTBhOWM0OTBkMzQyNTQxMDU2ZWRj
ZTdhMDEzOGI1MjlmOTljYzg5OWUKClNpZ25lZC1vZmYtYnk6IE1hc2FoaXJvIFlhbWFkYSA8bWFz
YWhpcm95QGtlcm5lbC5vcmc+Ci0tLQogaW5jbHVkZS91YXBpL2xpbnV4L3NpZ25hbC5oIHwgMiAr
KwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUv
dWFwaS9saW51eC9zaWduYWwuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9zaWduYWwuaAppbmRleCBl
MDMyMzhmOGQ0NzguLmM1YmJiZGIyZWEwZCAxMDA2NDQKLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4
L3NpZ25hbC5oCisrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9zaWduYWwuaApAQCAtMTMsNCArMTMs
NiBAQAogLyogbWFzayBmb3IgYWxsIFNTX3h4eCBmbGFncyAqLwogI2RlZmluZSBTU19GTEFHX0JJ
VFMJU1NfQVVUT0RJU0FSTQogCisjZGVmaW5lIERVTU1ZX0JBUiAxCisKICNlbmRpZiAvKiBfVUFQ
SV9MSU5VWF9TSUdOQUxfSCAqLwotLSAKMi4zNC4xCgo=
--00000000000009844705f509ae41--
