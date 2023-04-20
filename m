Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3846E9A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjDTRS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjDTRSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:18:11 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF675E5A;
        Thu, 20 Apr 2023 10:18:09 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2a8b1b51dbdso6267581fa.0;
        Thu, 20 Apr 2023 10:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682011088; x=1684603088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Gw0Rh9YeLkIBrYV42JC4HseprywVlHq2+xrB7m9pA8=;
        b=kO+D3M7ki7+BNCt0V3PlR4PA+WFJvb+py5kD3kN046+eGMn7ksincJOjKdxhNkaKLu
         K5JSI3+Fam1INeCMqJ7HoXnx7FsBUM/uqVIEPt+NJ2Ah29DsHxj7akVuGIGgqm2HNNqz
         XE4mRkCpM6ldy7W2+LNFLXfr/Q5Yz0FyeVW+8UB+AlOekheSXwF4/eHAJ50v5DBXmON/
         O1SBAfX6M78ft/YxLJUlvg/WEHD90GjLNtfGPLjaoqV7yRYlBtwTVrivxG9Vjxunp+fj
         gg1HGb++l80V4Pnxx0J+nKI8Lm1xFXWwbuslohYIAdm5cenbSF7RU9oRTclk/pFLKVr9
         fIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682011088; x=1684603088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Gw0Rh9YeLkIBrYV42JC4HseprywVlHq2+xrB7m9pA8=;
        b=UffBI1958LyTr8M8/ae5nb3CvseWMio9jET4bLNPjZMtzVu2BYYj2eSDUNh2RKAJJs
         1CDiZj5z4ADpMuShv1voGmAgc1rv1fT6C/x5bZt/D610fy4/dLG7G/NRx7TG2nzeGT3E
         hmCDVnMNWp2meJ9JYNfzLX/2LKrBQqd+rNipuO6I8YdDV/Z3EfYRC0P2xCr0m9bxJe91
         y1YHEyQqO6cm4Ar62uUPbjkTlUF18kYZPM6ZMY+njKuOPPuR8QEwmBr32eFQHxArkYEG
         G5WqV0/k9GGOLAZpUvhQ+fuo/IEoCvq+JwnTpNDDgqzq1HfBYLHDUNySS+6WLsnSNIKU
         Ysuw==
X-Gm-Message-State: AAQBX9cSZxkSvsPGO34gyRBvwYMFdvMzgb9PTk1myHuoQqkdaAiRLkxr
        rmWV6eJvmr7sPSDsSIo6N19avxLJXmSn1zeD0vQ=
X-Google-Smtp-Source: AKy350ZD5DNe1T8WEI38Kt9Tnq2EwrVj+Gfb5CSdkJxy0C+WHC4yighWj7jhjdgY87egOtj6fpCfLoz2IkXVyKJUas0=
X-Received: by 2002:ac2:4908:0:b0:4db:1999:67a3 with SMTP id
 n8-20020ac24908000000b004db199967a3mr588675lfi.13.1682011087869; Thu, 20 Apr
 2023 10:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230418214347.324156-1-ojeda@kernel.org> <CAPDJoNsG1E25yYM+L_H21vVCt-5S16etx3KMxx8ySZtWMQt4FQ@mail.gmail.com>
 <CANiq72mtb9V+1a7nPEHBCeg_fob4rpPTWJZjdahnGL2Mg3uoUA@mail.gmail.com>
In-Reply-To: <CANiq72mtb9V+1a7nPEHBCeg_fob4rpPTWJZjdahnGL2Mg3uoUA@mail.gmail.com>
From:   Ariel Miculas <ariel.miculas@gmail.com>
Date:   Thu, 20 Apr 2023 20:17:56 +0300
Message-ID: <CAPDJoNvGQBNN6X6fs26tjUy7LbpJjWwPvQuf=1+nSwj94aa6LA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Rust 1.68.2 upgrade
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Josh Stone <jistone@redhat.com>,
        William Brown <william.brown@suse.com>,
        Georgy Yakovlev <gyakovlev@gentoo.org>,
        Jan Alexander Steffens <jan.steffens@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I've edited the commands since I've run them out of order, let me
include the output of commands and my general setup.
Since I've already run these steps previously, most of the commands
just say that it's already configured.

=E2=9D=AF rustup override set $(scripts/min-tool-version.sh rustc)
info: using existing install for '1.68.2-x86_64-unknown-linux-gnu'
info: override toolchain for '/home/amiculas/work/linux' set to
'1.68.2-x86_64-unknown-linux-gnu'

  1.68.2-x86_64-unknown-linux-gnu unchanged - rustc 1.68.2 (9eb3afe9e
2023-03-27)

=E2=9D=AF rustup override list
/home/amiculas/work/linux                       1.68.2-x86_64-unknown-linux=
-gnu

=E2=9D=AF rustup component add rust-src
info: component 'rust-src' is up to date

=E2=9D=AF cargo install --locked --version $(scripts/min-tool-version.sh
bindgen) bindgen
     Ignored package `bindgen v0.56.0` is already installed, use
--force to override

=E2=9D=AF  make LLVM=3D1 rustavailable
Rust is available!

=E2=9D=AE rg -i '[^a-zA-Z]rust' .config
14:CONFIG_RUST_IS_AVAILABLE=3Dy
279:CONFIG_RUST=3Dy
280:CONFIG_RUSTC_VERSION_TEXT=3D"rustc 1.68.2 (9eb3afe9e 2023-03-27)"
687:CONFIG_HAVE_RUST=3Dy
5093:CONFIG_SAMPLES_RUST=3Dy
5094:CONFIG_SAMPLE_RUST_MINIMAL=3Dm
5095:CONFIG_SAMPLE_RUST_PRINT=3Dm
5096:CONFIG_SAMPLE_RUST_HOSTPROGS=3Dy
5185:# Rust hacking
5187:# CONFIG_RUST_DEBUG_ASSERTIONS is not set
5188:CONFIG_RUST_OVERFLOW_CHECKS=3Dy
5189:# CONFIG_RUST_BUILD_ASSERT_ALLOW is not set
5190:# end of Rust hacking

=E2=9D=AF make LLVM=3D1 -j$(nproc)
  DESCEND objtool
  CALL    scripts/checksyscalls.sh
make[3]: 'install_headers' is up to date.
grep: warning: stray \ before #
grep: warning: stray \ before #
Kernel: arch/x86/boot/bzImage is ready  (#29)

# I have some commits on top of the patchset, but they are only for
setting up the kernel environment (an initramfs with busybox, running
inside qemu)
=E2=9D=AF git log --oneline
03cad1754b24 (HEAD -> ariel-rust) Add lwnfs.ko kernel module to initramfs
233183beae92 Insert rust_fs.ko module and mount a rustfs to /mnt
a1de6ad1ec15 Add other rust samples to initramfs
192ab4a5dd58 Mount /dev, /proc and insert the parrot.ko module
05d7232d50cf enable kvm
c2724fa122af Add scripts for running the kernel in qemu
3f81af042dd2 (rust-next) rust: upgrade to Rust 1.68.2
418e1087dce1 rust: arc: fix intra-doc link in `Arc<T>::init`
ee16705fb79f rust: alloc: clarify what is the upstream version
1944caa8e8dc (rust-for-linux/rust-next) rust: sync: add functions for
initializing `UniqueArc<MaybeUninit<T>>`
701608bd030a rust: sync: reduce stack usage of `UniqueArc::try_new_uninit`
692e8935e23e rust: types: add `Opaque::ffi_init`

=E2=9D=AF git --no-pager diff
diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
index dc05f4bbe27e..1ca75c85f161 100644
--- a/samples/rust/rust_minimal.rs
+++ b/samples/rust/rust_minimal.rs
@@ -19,6 +19,7 @@ struct RustMinimal {
 impl kernel::Module for RustMinimal {
     fn init(_module: &'static ThisModule) -> Result<Self> {
         pr_info!("Rust minimal sample (init)\n");
+        pr_info!("Ariel was here");
         pr_info!("Am I built-in? {}\n", !cfg!(MODULE));

         let mut numbers =3D Vec::new();

=E2=9D=AF cd linux-environment
=E2=9D=AF ls
busybox  Makefile  qemu-initramfs.desc  qemu-initramfs.img
qemu-init.sh  run_qemu.sh

=E2=9D=AF file busybox
busybox: ELF 64-bit LSB executable, x86-64, version 1 (SYSV),
statically linked, stripped

=E2=9D=AF /usr/bin/cat Makefile
.PHONY: all clean

all: qemu-initramfs.img

qemu-initramfs.img:
        ../usr/gen_init_cpio qemu-initramfs.desc > qemu-initramfs.img

clean:
        rm qemu-initramfs.img

run: qemu-initramfs.img
        sudo ./run_qemu.sh

=E2=9D=AF /usr/bin/cat qemu-init.sh
#!/bin/sh

busybox mount -t devtmpfs none /dev
busybox mount -t proc none /proc
busybox mount -t sysfs none /sys

busybox insmod rust_minimal.ko
busybox rmmod rust_minimal.ko
busybox setsid sh -c 'exec sh -l </dev/ttyS0 >/dev/ttyS0 2>&1'

=E2=9D=AF /usr/bin/cat qemu-initramfs.desc
dir     /bin                                          0755 0 0
dir     /sys                                          0755 0 0
dir     /dev                                          0755 0 0
dir     /proc                                         0755 0 0
file    /bin/busybox  busybox                         0755 0 0
slink   /bin/sh       /bin/busybox                    0755 0 0
file    /init         qemu-init.sh                    0755 0 0

file    /rust_minimal.ko            ../samples/rust/rust_minimal.ko
        0755 0 0
file    /rust_print.ko              ../samples/rust/rust_print.ko
        0755 0 0

=E2=9D=AF make
../usr/gen_init_cpio qemu-initramfs.desc > qemu-initramfs.img

=E2=9D=AF /usr/bin/cat run_qemu.sh
sudo qemu-system-x86_64 \
    -kernel ../arch/x86/boot/bzImage \
    -initrd qemu-initramfs.img \
    -M pc \
    -m 4G \
    -accel kvm \
    -cpu host \
    -smp $(nproc) \
    -nographic \
    -vga none \
    -no-reboot \
    -append 'console=3DttyS0'

=E2=9D=AF ./run_qemu.sh
[sudo] password for amiculas:
SeaBIOS (version Arch Linux 1.16.2-1-1)


iPXE (http://ipxe.org) 00:02.0 C000 PCI2.10 PnP PMM+BEFD31B0+BEF331B0 C000



Booting from ROM..
[    0.000000] Linux version 6.3.0-rc6-00039-g03cad1754b24-dirty
(amiculas@archlinux-cisco) (clang version 15.0.7, LLD 15.0.7) #29 SMP
PREEMPT_DYNAMIC Thu Apr 20 15:54:18 EEST 2023
[    0.000000] Command line: console=3DttyS0
...
[    0.802414] Run /init as init process
[    0.803185] busybox (89) used greatest stack depth: 13848 bytes left
[    0.805450] rust_minimal: Rust minimal sample (init)
[    0.805736] rust_minimal: Ariel was here
[    0.805737] rust_minimal: Am I built-in? false
[    0.806304] busybox (92) used greatest stack depth: 13696 bytes left
[    0.806591] rust_minimal: My numbers are [72, 108, 200]
[    0.807021] rust_minimal: Rust minimal sample (exit)

Cheers,
Ariel

On Thu, Apr 20, 2023 at 4:20=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Apr 20, 2023 at 3:13=E2=80=AFPM Ariel Miculas <ariel.miculas@gmai=
l.com> wrote:
> >
> > $ make LLVM=3D1 rustavailable
>
> Since you showed the output of the other commands, did this one show
> "Rust is available!"? I guess so -- I imagine you edited the commands
> for the email, e.g. the config changed too.
>
> That is fine, as long as it works as expected :) Thanks a lot for testing=
!
>
> Cheers,
> Miguel
