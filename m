Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223295B7868
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiIMRme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbiIMRmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:42:00 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346D521269
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 09:35:27 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id f14so20070536lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 09:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=up1QkUkMk8Fqy1w/nWYRGg5eriBa7b5y9km817AkDAI=;
        b=l3TbblAaBEfsAjkfHDhSgFjqU2XPPg7ipVkY8VfAcIRRhizLvLrjQoTeGbSbzVBnYt
         KG2JGdSB8Sr8c65J4F0jKrfUPtjvEHDy0q6cv/atcbPVhPl1VPkdA/WzMP3Nl5A97vSH
         kY9inKphD6YdXFUcu0ts4DjV3KZthjDUulDHwReHT8Fr0IjOyYw3B2q/WG9W9/IsLw0e
         Wfz/ZMq+jfxI2/kx+D6apdjtVnHrPSee3NuJdms4/cKyyyTtMAsWfgHhsHalfVpzLGM3
         jaBbOf3VQHvuqdpgUrJk5RZpsyC4mQLWNdvbOGxO8XLrgwNFq8r/gtIz/GCqIIKcrv4g
         s8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=up1QkUkMk8Fqy1w/nWYRGg5eriBa7b5y9km817AkDAI=;
        b=VHE/U84bU+acbcDLQIS9Hy5MDUNETKXEODbWzQaTfmoiq4nQ8IPFcdLxp+nCUo6yET
         3IfqTamiG93fTKLMCTbo61VGN45B6eUKjg32VWDs3BmRSJ7dGHz/UTWaFd7Av2VWoKcy
         rlDcK0ERw6L5N/Ikwca6w4qC8/jy5lfPAKoIVy8dKyAGi/Du6JX7lNQdDIq9NOuoS9K4
         /iYFYbJCX6vglrW9Bljdu7K4PzlYmWTWklyg7/pfWKExcE8S4OY40yJCQwRHAL9ZxdFH
         PbuMozettoubKPDoCnbtYjAGof/XSwRTiirjNIcq5y5mHPfT9bcFxebL0tmD+LLSdBOp
         uzUw==
X-Gm-Message-State: ACgBeo2QYTJL11ZBLMhMyKaMGTP1lrGyZLS/s2hfah8jVLdJLVkUCRu6
        FcITAKeW215J3CSOFw8YcpMD2a6vZiWBFieB9vQ=
X-Google-Smtp-Source: AA6agR4uVjbkGBiDovSsmWTVyNcnmQ1mi7+tpuFU02qM+AlpkshRmbZt9o3/7aes7DbMKUyxBiWjENbn7aIeznGI6sc=
X-Received: by 2002:a05:6512:6c3:b0:49a:d227:1b5b with SMTP id
 u3-20020a05651206c300b0049ad2271b5bmr3338559lff.386.1663086924639; Tue, 13
 Sep 2022 09:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220913102551.1121611-1-avagin@google.com> <202209130435.12231CE199@keescook>
In-Reply-To: <202209130435.12231CE199@keescook>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Tue, 13 Sep 2022 09:35:13 -0700
Message-ID: <CANaxB-y3E3DgFHKM6qpgc5z-b4imdDBBKy_wnS9_Mjq6tgSAMQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Revert "fs/exec: allow to unshare a time namespace on vfork+exec"
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrei Vagin <avagin@google.com>, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000005fd29f05e89199ef"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000005fd29f05e89199ef
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 13, 2022 at 5:18 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Sep 13, 2022 at 03:25:49AM -0700, Andrei Vagin wrote:
> > This reverts commits:
> > 133e2d3e81de ("fs/exec: allow to unshare a time namespace on vfork+exec")
> > 6342140db660 ("selftests/timens: add a test for vfork+exit")
> >
> > Alexey pointed out a few undesirable side effects of the reverted change.
> > First, it doesn't take into account that CLONE_VFORK can be used with
> > CLONE_THREAD. Second, a child process doesn't enter a target time name-space,
> > if its parent dies before the child calls exec. It happens because the parent
> > clears vfork_done.
> >
> > Eric W. Biederman suggests installing a time namespace as a task gets a new mm.
> > It includes all new processes cloned without CLONE_VM and all tasks that call
> > exec(). This is an user API change, but we think there aren't users that depend
> > on the old behavior.
>
> Can we include that patch here as well?

It is attached. I need to test it and then I will send it properly.

>
> > It is too late to make such changes in this release, so let's roll back
> > this patch and introduce the right one in the next release.
>
> Do you mean you'd like this revert to land for v6.0, and we should wait
> for the new API for later?

Yes, I mean this. I think we should merge the new patch in v6.1-rc1 so
it sits there for a while.

Thanks,
Andrei

--0000000000005fd29f05e89199ef
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fs-exec-switch-timens-when-a-task-gets-a-new-mm.patch"
Content-Disposition: attachment; 
	filename="0001-fs-exec-switch-timens-when-a-task-gets-a-new-mm.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l80ezum30>
X-Attachment-Id: f_l80ezum30

RnJvbSAyM2UwNmIxNDM1NGIzMjhhMTAwMjI5YzJkNWM2NmIxZDFmZmM3YTZmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZWkgVmFnaW4gPGF2YWdpbkBnbWFpbC5jb20+CkRhdGU6
IFR1ZSwgMTMgU2VwIDIwMjIgMTQ6MTA6MjggKzAwMDAKU3ViamVjdDogW1BBVENIXSBmcy9leGVj
OiBzd2l0Y2ggdGltZW5zIHdoZW4gYSB0YXNrIGdldHMgYSBuZXcgbW0KCkNoYW5naW5nIGEgdGlt
ZSBuYW1lc3BhY2UgcmVxdWlyZXMgcmVtYXBwaW5nIGEgdnZhciBwYWdlLCBzbyB3ZSBkb24ndCB3
YW50IHRvCmFsbG93IGRvaW5nIHRoYXQgaWYgYW55IG90aGVyIHRhc2tzIGNhbiB1c2UgdGhlIHNh
bWUgbW0uCgpDdXJyZW50bHksIHdlIGluc3RhbGwgYSB0aW1lIG5hbWVzcGFjZSB3aGVuIGEgdGFz
ayBpcyBjbG9uZWQgd2l0aG91dCBDTE9ORV9WTS4KZXhlYygpIGlzIGFub3RoZXIgY2FzZSB3aGVu
IGEgdGFzayBnZXRzIGEgbmV3IG1tIGFuZCBzbyBpdCBjYW4gc3dpdGNoIGEKdGltZSBuYW1lc3Bh
Y2Ugc2FmZWx5LCBidXQgdGhpcyBjYXNlIGlzbid0IGhhbmRsZWQgbm93LgoKT25lIG1vcmUgaXNz
dWUgb2YgdGhlIGN1cnJlbnQgaW50ZXJmYWNlIGlzIHRoYXQgY2xvbmUoKSB3aXRoIENMT05FX1ZN
IGlzbid0CmFsbG93ZWQgaWYgdGhlIGN1cnJlbnQgdGFzayBoYXMgdW5zaGFyZWQgYSB0aW1lIG5h
bWVzcGFjZSAodGltZW5zX2Zvcl9jaGlsZHJlbgpkb2Vzbid0IG1hdGNoIHRoZSBjdXJyZW50IHRp
bWVucykuCgpCb3RoIHRoZXNlIGlzc3VlcyBtYWtlIHNvbWUgaW5jb252ZW5pZW5jZSBmb3IgdXNl
cnMuIEZvciBleGFtcGxlLCBGbG9yaWFuCnJlcG9ydGVkIHRoYXQgcG9zaXhfc3Bhd24oKSB1c2Vz
IHZmb3JrK2V4ZWMgYW5kIHRoaXMgcGF0dGVybiBkb2Vzbid0IHdvcmsgd2VsbAp3aXRoIHRpbWUg
bmFtZXNwYWNlcyBkdWUgdG8gdGhlIGJvdGggZGVzY3JpYmVkIGlzc3Vlcy4gTFhDIG5lZWRlZCB0
byB3b3JrYXJvdW5kCnRoZSBleGVjKCkgaXNzdWUgYnkgY2FsbGluZyBzZXRucy4KCkluIDEzM2Uy
ZDNlODFkZTUgImZzL2V4ZWM6IGFsbG93IHRvIHVuc2hhcmUgYSB0aW1lIG5hbWVzcGFjZSBvbiB2
Zm9yaytleGVjIiwgd2UKdHJpZWQgdG8gZml4IHRoZXNlIGlzc3VlcyB3aXRoIG1pbmltYWwgaW1w
YWN0IG9uIFVBUEkuIEJ1dCBpdCBhZGRzIGV4dHJhCmNvbXBsZXhpdHkgYW5kIHNvbWUgdW5kZXNp
cmFibGUgc2lkZSBlZmZlY3RzLiBFcmljIHN1Z2dlc3RlZCBmaXhpbmcgdGhlIGlzc3Vlcwpwcm9w
ZXJseSBiZWNhdXNlIGhlcmUgYXJlIGFsbCB0aGUgcmVhc29ucyB0byBzdXBwb3NlIHRoYXQgdGhl
cmUgYXJlIG5vIHVzZXJzCnRoYXQgZGVwZW5kIG9uIHRoZSBvbGQgYmVoYXZpb3IuCgpDYzogQWxl
eGV5IEl6YnlzaGV2IDxpemJ5c2hldkBpc3ByYXMucnU+CkNjOiBDaHJpc3RpYW4gQnJhdW5lciA8
YnJhdW5lckBrZXJuZWwub3JnPgpDYzogRG1pdHJ5IFNhZm9ub3YgPDB4N2Y0NTRjNDZAZ21haWwu
Y29tPgpDYzogIkVyaWMgVy4gQmllZGVybWFuIiA8ZWJpZWRlcm1AeG1pc3Npb24uY29tPgpDYzog
RmxvcmlhbiBXZWltZXIgPGZ3ZWltZXJAcmVkaGF0LmNvbT4KQ2M6IEtlZXMgQ29vayA8a2Vlc2Nv
b2tAY2hyb21pdW0ub3JnPgpTdWdnZXN0ZWQtYnk6ICJFcmljIFcuIEJpZWRlcm1hbiIgPGViaWVk
ZXJtQHhtaXNzaW9uLmNvbT4KT3JpZ2luYWwtYXV0aG9yOiAiRXJpYyBXLiBCaWVkZXJtYW4iIDxl
YmllZGVybUB4bWlzc2lvbi5jb20+ClNpZ25lZC1vZmYtYnk6IEFuZHJlaSBWYWdpbiA8YXZhZ2lu
QGdtYWlsLmNvbT4KLS0tCiBmcy9leGVjLmMgICAgICAgICAgICAgICB8ICA1ICsrKysrCiBpbmNs
dWRlL2xpbnV4L25zcHJveHkuaCB8ICAxICsKIGtlcm5lbC9mb3JrLmMgICAgICAgICAgIHwgIDkg
LS0tLS0tLS0tCiBrZXJuZWwvbnNwcm94eS5jICAgICAgICB8IDIzICsrKysrKysrKysrKysrKysr
KysrKy0tCiA0IGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2ZzL2V4ZWMuYyBiL2ZzL2V4ZWMuYwppbmRleCBkMDQ2ZGJiOWNiZDAu
LjcxMjg0MTg4Yjk2ZCAxMDA2NDQKLS0tIGEvZnMvZXhlYy5jCisrKyBiL2ZzL2V4ZWMuYwpAQCAt
NjUsNiArNjUsNyBAQAogI2luY2x1ZGUgPGxpbnV4L2lvX3VyaW5nLmg+CiAjaW5jbHVkZSA8bGlu
dXgvc3lzY2FsbF91c2VyX2Rpc3BhdGNoLmg+CiAjaW5jbHVkZSA8bGludXgvY29yZWR1bXAuaD4K
KyNpbmNsdWRlIDxsaW51eC90aW1lX25hbWVzcGFjZS5oPgogCiAjaW5jbHVkZSA8bGludXgvdWFj
Y2Vzcy5oPgogI2luY2x1ZGUgPGFzbS9tbXVfY29udGV4dC5oPgpAQCAtMTI5Niw2ICsxMjk3LDEw
IEBAIGludCBiZWdpbl9uZXdfZXhlYyhzdHJ1Y3QgbGludXhfYmlucHJtICogYnBybSkKIAogCWJw
cm0tPm1tID0gTlVMTDsKIAorCXJldHZhbCA9IGV4ZWNfdGFza19uYW1lc3BhY2VzKCk7CisJaWYg
KHJldHZhbCkKKwkJZ290byBvdXRfdW5sb2NrOworCiAjaWZkZWYgQ09ORklHX1BPU0lYX1RJTUVS
UwogCXNwaW5fbG9ja19pcnEoJm1lLT5zaWdoYW5kLT5zaWdsb2NrKTsKIAlwb3NpeF9jcHVfdGlt
ZXJzX2V4aXQobWUpOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9uc3Byb3h5LmggYi9pbmNs
dWRlL2xpbnV4L25zcHJveHkuaAppbmRleCBjZGIxNzFlZmM3Y2IuLmZlZTg4MWNkZWQwMSAxMDA2
NDQKLS0tIGEvaW5jbHVkZS9saW51eC9uc3Byb3h5LmgKKysrIGIvaW5jbHVkZS9saW51eC9uc3By
b3h5LmgKQEAgLTk0LDYgKzk0LDcgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgY3JlZCAqbnNzZXRf
Y3JlZChzdHJ1Y3QgbnNzZXQgKnNldCkKIGludCBjb3B5X25hbWVzcGFjZXModW5zaWduZWQgbG9u
ZyBmbGFncywgc3RydWN0IHRhc2tfc3RydWN0ICp0c2spOwogdm9pZCBleGl0X3Rhc2tfbmFtZXNw
YWNlcyhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzayk7CiB2b2lkIHN3aXRjaF90YXNrX25hbWVzcGFj
ZXMoc3RydWN0IHRhc2tfc3RydWN0ICp0c2ssIHN0cnVjdCBuc3Byb3h5ICpuZXcpOworaW50IGV4
ZWNfdGFza19uYW1lc3BhY2VzKHZvaWQpOwogdm9pZCBmcmVlX25zcHJveHkoc3RydWN0IG5zcHJv
eHkgKm5zKTsKIGludCB1bnNoYXJlX25zcHJveHlfbmFtZXNwYWNlcyh1bnNpZ25lZCBsb25nLCBz
dHJ1Y3QgbnNwcm94eSAqKiwKIAlzdHJ1Y3QgY3JlZCAqLCBzdHJ1Y3QgZnNfc3RydWN0ICopOwpk
aWZmIC0tZ2l0IGEva2VybmVsL2ZvcmsuYyBiL2tlcm5lbC9mb3JrLmMKaW5kZXggMmI2YmQ1MTFj
NmVkLi40ZWI4MDNmNzUyMjUgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9mb3JrLmMKKysrIGIva2VybmVs
L2ZvcmsuYwpAQCAtMjA0NCwxNSArMjA0NCw2IEBAIHN0YXRpYyBfX2xhdGVudF9lbnRyb3B5IHN0
cnVjdCB0YXNrX3N0cnVjdCAqY29weV9wcm9jZXNzKAogCQkJcmV0dXJuIEVSUl9QVFIoLUVJTlZB
TCk7CiAJfQogCi0JLyoKLQkgKiBJZiB0aGUgbmV3IHByb2Nlc3Mgd2lsbCBiZSBpbiBhIGRpZmZl
cmVudCB0aW1lIG5hbWVzcGFjZQotCSAqIGRvIG5vdCBhbGxvdyBpdCB0byBzaGFyZSBWTSBvciBh
IHRocmVhZCBncm91cCB3aXRoIHRoZSBmb3JraW5nIHRhc2suCi0JICovCi0JaWYgKGNsb25lX2Zs
YWdzICYgKENMT05FX1RIUkVBRCB8IENMT05FX1ZNKSkgewotCQlpZiAobnNwLT50aW1lX25zICE9
IG5zcC0+dGltZV9uc19mb3JfY2hpbGRyZW4pCi0JCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsK
LQl9Ci0KIAlpZiAoY2xvbmVfZmxhZ3MgJiBDTE9ORV9QSURGRCkgewogCQkvKgogCQkgKiAtIENM
T05FX0RFVEFDSEVEIGlzIGJsb2NrZWQgc28gdGhhdCB3ZSBjYW4gcG90ZW50aWFsbHkKZGlmZiAt
LWdpdCBhL2tlcm5lbC9uc3Byb3h5LmMgYi9rZXJuZWwvbnNwcm94eS5jCmluZGV4IGVlYzcyY2E5
NjJlMi4uYTQ4N2ZmMjQxMjliIDEwMDY0NAotLS0gYS9rZXJuZWwvbnNwcm94eS5jCisrKyBiL2tl
cm5lbC9uc3Byb3h5LmMKQEAgLTE1Nyw3ICsxNTcsOCBAQCBpbnQgY29weV9uYW1lc3BhY2VzKHVu
c2lnbmVkIGxvbmcgZmxhZ3MsIHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrKQogCWlmIChsaWtlbHko
IShmbGFncyAmIChDTE9ORV9ORVdOUyB8IENMT05FX05FV1VUUyB8IENMT05FX05FV0lQQyB8CiAJ
CQkgICAgICBDTE9ORV9ORVdQSUQgfCBDTE9ORV9ORVdORVQgfAogCQkJICAgICAgQ0xPTkVfTkVX
Q0dST1VQIHwgQ0xPTkVfTkVXVElNRSkpKSkgewotCQlpZiAobGlrZWx5KG9sZF9ucy0+dGltZV9u
c19mb3JfY2hpbGRyZW4gPT0gb2xkX25zLT50aW1lX25zKSkgeworCQlpZiAoKGZsYWdzICYgQ0xP
TkVfVk0pIHx8CisJCSAgICBsaWtlbHkob2xkX25zLT50aW1lX25zX2Zvcl9jaGlsZHJlbiA9PSBv
bGRfbnMtPnRpbWVfbnMpKSB7CiAJCQlnZXRfbnNwcm94eShvbGRfbnMpOwogCQkJcmV0dXJuIDA7
CiAJCX0KQEAgLTE3OSw3ICsxODAsOCBAQCBpbnQgY29weV9uYW1lc3BhY2VzKHVuc2lnbmVkIGxv
bmcgZmxhZ3MsIHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrKQogCWlmIChJU19FUlIobmV3X25zKSkK
IAkJcmV0dXJuICBQVFJfRVJSKG5ld19ucyk7CiAKLQl0aW1lbnNfb25fZm9yayhuZXdfbnMsIHRz
ayk7CisJaWYgKChmbGFncyAmIENMT05FX1ZNKSA9PSAwKQorCQl0aW1lbnNfb25fZm9yayhuZXdf
bnMsIHRzayk7CiAKIAl0c2stPm5zcHJveHkgPSBuZXdfbnM7CiAJcmV0dXJuIDA7CkBAIC0yNTQs
NiArMjU2LDIzIEBAIHZvaWQgZXhpdF90YXNrX25hbWVzcGFjZXMoc3RydWN0IHRhc2tfc3RydWN0
ICpwKQogCXN3aXRjaF90YXNrX25hbWVzcGFjZXMocCwgTlVMTCk7CiB9CiAKK2ludCBleGVjX3Rh
c2tfbmFtZXNwYWNlcyh2b2lkKQoreworCXN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrID0gY3VycmVu
dDsKKwlzdHJ1Y3QgbnNwcm94eSAqbmV3OworCisJaWYgKHRzay0+bnNwcm94eS0+dGltZV9uc19m
b3JfY2hpbGRyZW4gPT0gdHNrLT5uc3Byb3h5LT50aW1lX25zKQorCQlyZXR1cm4gMDsKKworCW5l
dyA9IGNyZWF0ZV9uZXdfbmFtZXNwYWNlcygwLCB0c2ssIGN1cnJlbnRfdXNlcl9ucygpLCB0c2st
PmZzKTsKKwlpZiAoSVNfRVJSKG5ldykpCisJCXJldHVybiBQVFJfRVJSKG5ldyk7CisKKwl0aW1l
bnNfb25fZm9yayhuZXcsIHRzayk7CisJc3dpdGNoX3Rhc2tfbmFtZXNwYWNlcyh0c2ssIG5ldyk7
CisJcmV0dXJuIDA7Cit9CisKIHN0YXRpYyBpbnQgY2hlY2tfc2V0bnNfZmxhZ3ModW5zaWduZWQg
bG9uZyBmbGFncykKIHsKIAlpZiAoIWZsYWdzIHx8IChmbGFncyAmIH4oQ0xPTkVfTkVXTlMgfCBD
TE9ORV9ORVdVVFMgfCBDTE9ORV9ORVdJUEMgfAotLSAKMi4zNy4yLjc4OS5nNjE4MzM3NzIyNC1n
b29nCgo=
--0000000000005fd29f05e89199ef--
