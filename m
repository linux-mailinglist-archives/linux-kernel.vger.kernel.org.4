Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3F46DFDEE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjDLSub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDLSu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:50:29 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5924EE5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:50:25 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id j19so4208067qkk.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681325424; x=1683917424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvDyon89ZBE9ZMeK/zkZ7rwiI33jPWYUrd00HgHlIkk=;
        b=t9F+HuoYdiQzYRHroae+8OYkBXhBqYl5a/W0sE7f3tVyJ9ca0BUy2vjtH1ikByb/Bk
         mCyZbhdxIQHv8+SrWX7ETzvPQaFHm/XEo+ziKPCBE4T1VIM1uUETlT5FWAKT1CozEaOC
         Rm52v0oL1DLfuUej30nhqkPYp/DAIQLq/FyfZjExdGD8LRGqN7tZl069Bllo//5oQi9R
         wR3nfceFBV6KULT5tLayWfrn3E+jjpHM22itYli5NX0xsg1UCGJPtLynJFBjxmxFArur
         C3o9FSXRPXhFpsQfVENZk8+B870eM6zpuf8tLHemGCu2Mb9vlx963NuNCa2GHgn452+F
         ak5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681325424; x=1683917424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvDyon89ZBE9ZMeK/zkZ7rwiI33jPWYUrd00HgHlIkk=;
        b=hI4O/nsBa1tw2Y2pFpZr5pGUqMRCymJBIlHrZl9VYV3N+khxNc1wehxIH1PUAvyyiO
         EnymB8ckKioGEBKZT0fIUPE0SsskdNe1ZjtjFofy48wcENM0Bo6JR72qWe3udF7UJTzH
         4bj6N/1OY+3/hMfk+GW4XNlWWK4yB6+1ETvRUP0aZewZ+0/HW4/yN8I8x/Cq1lSKUh9M
         rsBMjmVatk6+bE1IOtJ7mXrNP0Ybq0NpZVqFnpojSVUrzZgHftpEwJk7DT0w7mh3KTPm
         QC0aIqcYOHsu/c2PllD3Cc2IfKzpT+FgksHQEa06+4cpcxm8sN/pwW0MwZ42WUK6s5+U
         UcIQ==
X-Gm-Message-State: AAQBX9f4c75s6dujs6YIpX941iA2p6UrS8MeoC56+Guut1XU244X/0oX
        mSWW55QYePhKd2WQAwdjC4RJRTqslAFAIj+dlrYLUA==
X-Google-Smtp-Source: AKy350aHu3KRksQYt0bXRFW+On3NL3Fhgq28Ft0uTja1fNebDwRig3lMQED5Bi2cRNGTv/qdwW7KMnbl1V2FrdzxEw0=
X-Received: by 2002:a05:620a:471e:b0:74a:cb35:3daa with SMTP id
 bs30-20020a05620a471e00b0074acb353daamr604582qkb.11.1681325424289; Wed, 12
 Apr 2023 11:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230411180409.1706067-1-jstultz@google.com>
In-Reply-To: <20230411180409.1706067-1-jstultz@google.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Thu, 13 Apr 2023 00:19:48 +0530
Message-ID: <CAMi1Hd2orxv_6-=s-3wAgKXgYtcnv7hUMJPVeX1y3WevOHNWjw@mail.gmail.com>
Subject: Re: [RFC][PATCH] kernel/configs: Drop Android config fragments
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 at 23:34, John Stultz <jstultz@google.com> wrote:
>
> In the old days where each device had a custom kernel, the
> android config fragments were useful to provide the required
> and reccomended options expected by userland.
>
> However, these days devices are expected to use the GKI kernel,
> so these config fragments no longer needed, and out of date, so
> they seem to only cause confusion.
>
> So lets drop them. If folks are curious what configs are
> expected by the Android environment, check out the gki_defconfig
> file in the latest android common kernel tree.

ACK on removing these old and outdated config fragments.

But it still doesn't solve the missing AOSP/Android defconfig problem
in the mainline kernel. Though there are no not many AOSP developers
running mainline kernel on their devices or developers who care about
the state of running AOSP with mainline kernel, but how about we push
$android-mainline's gki_defconfig (or mainline equivalent of
gki_defconfig) in the mainline?

For example:
Submit $android-mainline/arch/arm64/configs/gki_defconfig as
kernel/configs/gki_aarch64.config and then users can prepare
android_defconfig by running:

KCONFIG_CONFIG=3Darch/arm64/configs/android_defconfig \
scripts/kconfig/merge_config.sh -m -r arch/arm64/configs/defconfig \
kernel/configs/gki_aarch64.config

Regards,
Amit Pundir


>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Amit Pundir <amit.pundir@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: kernel-team@android.com
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>  MAINTAINERS                               |   5 -
>  kernel/configs/android-base.config        | 159 ----------------------
>  kernel/configs/android-recommended.config | 127 -----------------
>  3 files changed, 291 deletions(-)
>  delete mode 100644 kernel/configs/android-base.config
>  delete mode 100644 kernel/configs/android-recommended.config
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90abe83c02f3..541296ecc879 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1428,11 +1428,6 @@ S:       Supported
>  F:     drivers/clk/analogbits/*
>  F:     include/linux/clk/analogbits*
>
> -ANDROID CONFIG FRAGMENTS
> -M:     Rob Herring <robh@kernel.org>
> -S:     Supported
> -F:     kernel/configs/android*
> -
>  ANDROID DRIVERS
>  M:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  M:     Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> diff --git a/kernel/configs/android-base.config b/kernel/configs/android-=
base.config
> deleted file mode 100644
> index 44b0f0146a3f..000000000000
> --- a/kernel/configs/android-base.config
> +++ /dev/null
> @@ -1,159 +0,0 @@
> -#  KEEP ALPHABETICALLY SORTED
> -# CONFIG_DEVMEM is not set
> -# CONFIG_FHANDLE is not set
> -# CONFIG_INET_LRO is not set
> -# CONFIG_NFSD is not set
> -# CONFIG_NFS_FS is not set
> -# CONFIG_OABI_COMPAT is not set
> -# CONFIG_SYSVIPC is not set
> -# CONFIG_USELIB is not set
> -CONFIG_ANDROID_BINDER_IPC=3Dy
> -CONFIG_ANDROID_BINDER_DEVICES=3Dbinder,hwbinder,vndbinder
> -CONFIG_ANDROID_LOW_MEMORY_KILLER=3Dy
> -CONFIG_ARMV8_DEPRECATED=3Dy
> -CONFIG_ASHMEM=3Dy
> -CONFIG_AUDIT=3Dy
> -CONFIG_BLK_DEV_INITRD=3Dy
> -CONFIG_CGROUPS=3Dy
> -CONFIG_CGROUP_BPF=3Dy
> -CONFIG_CGROUP_CPUACCT=3Dy
> -CONFIG_CGROUP_DEBUG=3Dy
> -CONFIG_CGROUP_FREEZER=3Dy
> -CONFIG_CGROUP_SCHED=3Dy
> -CONFIG_CP15_BARRIER_EMULATION=3Dy
> -CONFIG_DEFAULT_SECURITY_SELINUX=3Dy
> -CONFIG_EMBEDDED=3Dy
> -CONFIG_FB=3Dy
> -CONFIG_HARDENED_USERCOPY=3Dy
> -CONFIG_HIGH_RES_TIMERS=3Dy
> -CONFIG_IKCONFIG=3Dy
> -CONFIG_IKCONFIG_PROC=3Dy
> -CONFIG_INET6_AH=3Dy
> -CONFIG_INET6_ESP=3Dy
> -CONFIG_INET6_IPCOMP=3Dy
> -CONFIG_INET=3Dy
> -CONFIG_INET_DIAG_DESTROY=3Dy
> -CONFIG_INET_ESP=3Dy
> -CONFIG_INET_XFRM_MODE_TUNNEL=3Dy
> -CONFIG_IP6_NF_FILTER=3Dy
> -CONFIG_IP6_NF_IPTABLES=3Dy
> -CONFIG_IP6_NF_MANGLE=3Dy
> -CONFIG_IP6_NF_RAW=3Dy
> -CONFIG_IP6_NF_TARGET_REJECT=3Dy
> -CONFIG_IPV6=3Dy
> -CONFIG_IPV6_MIP6=3Dy
> -CONFIG_IPV6_MULTIPLE_TABLES=3Dy
> -CONFIG_IPV6_OPTIMISTIC_DAD=3Dy
> -CONFIG_IPV6_ROUTER_PREF=3Dy
> -CONFIG_IPV6_ROUTE_INFO=3Dy
> -CONFIG_IP_ADVANCED_ROUTER=3Dy
> -CONFIG_IP_MULTICAST=3Dy
> -CONFIG_IP_MULTIPLE_TABLES=3Dy
> -CONFIG_IP_NF_ARPFILTER=3Dy
> -CONFIG_IP_NF_ARPTABLES=3Dy
> -CONFIG_IP_NF_ARP_MANGLE=3Dy
> -CONFIG_IP_NF_FILTER=3Dy
> -CONFIG_IP_NF_IPTABLES=3Dy
> -CONFIG_IP_NF_MANGLE=3Dy
> -CONFIG_IP_NF_MATCH_AH=3Dy
> -CONFIG_IP_NF_MATCH_ECN=3Dy
> -CONFIG_IP_NF_MATCH_TTL=3Dy
> -CONFIG_IP_NF_NAT=3Dy
> -CONFIG_IP_NF_RAW=3Dy
> -CONFIG_IP_NF_SECURITY=3Dy
> -CONFIG_IP_NF_TARGET_MASQUERADE=3Dy
> -CONFIG_IP_NF_TARGET_NETMAP=3Dy
> -CONFIG_IP_NF_TARGET_REDIRECT=3Dy
> -CONFIG_IP_NF_TARGET_REJECT=3Dy
> -CONFIG_MODULES=3Dy
> -CONFIG_MODULE_UNLOAD=3Dy
> -CONFIG_MODVERSIONS=3Dy
> -CONFIG_NET=3Dy
> -CONFIG_NETDEVICES=3Dy
> -CONFIG_NETFILTER=3Dy
> -CONFIG_NETFILTER_TPROXY=3Dy
> -CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dy
> -CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=3Dy
> -CONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dy
> -CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dy
> -CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=3Dy
> -CONFIG_NETFILTER_XT_MATCH_HELPER=3Dy
> -CONFIG_NETFILTER_XT_MATCH_IPRANGE=3Dy
> -CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dy
> -CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dy
> -CONFIG_NETFILTER_XT_MATCH_MAC=3Dy
> -CONFIG_NETFILTER_XT_MATCH_MARK=3Dy
> -CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dy
> -CONFIG_NETFILTER_XT_MATCH_POLICY=3Dy
> -CONFIG_NETFILTER_XT_MATCH_QUOTA=3Dy
> -CONFIG_NETFILTER_XT_MATCH_SOCKET=3Dy
> -CONFIG_NETFILTER_XT_MATCH_STATE=3Dy
> -CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dy
> -CONFIG_NETFILTER_XT_MATCH_STRING=3Dy
> -CONFIG_NETFILTER_XT_MATCH_TIME=3Dy
> -CONFIG_NETFILTER_XT_MATCH_U32=3Dy
> -CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dy
> -CONFIG_NETFILTER_XT_TARGET_CONNMARK=3Dy
> -CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=3Dy
> -CONFIG_NETFILTER_XT_TARGET_IDLETIMER=3Dy
> -CONFIG_NETFILTER_XT_TARGET_MARK=3Dy
> -CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dy
> -CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dy
> -CONFIG_NETFILTER_XT_TARGET_SECMARK=3Dy
> -CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dy
> -CONFIG_NETFILTER_XT_TARGET_TPROXY=3Dy
> -CONFIG_NETFILTER_XT_TARGET_TRACE=3Dy
> -CONFIG_NET_CLS_ACT=3Dy
> -CONFIG_NET_CLS_U32=3Dy
> -CONFIG_NET_EMATCH=3Dy
> -CONFIG_NET_EMATCH_U32=3Dy
> -CONFIG_NET_KEY=3Dy
> -CONFIG_NET_SCHED=3Dy
> -CONFIG_NET_SCH_HTB=3Dy
> -CONFIG_NF_CONNTRACK=3Dy
> -CONFIG_NF_CONNTRACK_AMANDA=3Dy
> -CONFIG_NF_CONNTRACK_EVENTS=3Dy
> -CONFIG_NF_CONNTRACK_FTP=3Dy
> -CONFIG_NF_CONNTRACK_H323=3Dy
> -CONFIG_NF_CONNTRACK_IPV4=3Dy
> -CONFIG_NF_CONNTRACK_IPV6=3Dy
> -CONFIG_NF_CONNTRACK_IRC=3Dy
> -CONFIG_NF_CONNTRACK_NETBIOS_NS=3Dy
> -CONFIG_NF_CONNTRACK_PPTP=3Dy
> -CONFIG_NF_CONNTRACK_SANE=3Dy
> -CONFIG_NF_CONNTRACK_SECMARK=3Dy
> -CONFIG_NF_CONNTRACK_TFTP=3Dy
> -CONFIG_NF_CT_NETLINK=3Dy
> -CONFIG_NF_CT_PROTO_DCCP=3Dy
> -CONFIG_NF_CT_PROTO_SCTP=3Dy
> -CONFIG_NF_CT_PROTO_UDPLITE=3Dy
> -CONFIG_NF_NAT=3Dy
> -CONFIG_NO_HZ=3Dy
> -CONFIG_PACKET=3Dy
> -CONFIG_PM_AUTOSLEEP=3Dy
> -CONFIG_PM_WAKELOCKS=3Dy
> -CONFIG_PPP=3Dy
> -CONFIG_PPP_BSDCOMP=3Dy
> -CONFIG_PPP_DEFLATE=3Dy
> -CONFIG_PPP_MPPE=3Dy
> -CONFIG_PREEMPT=3Dy
> -CONFIG_QUOTA=3Dy
> -CONFIG_RANDOMIZE_BASE=3Dy
> -CONFIG_RTC_CLASS=3Dy
> -CONFIG_RT_GROUP_SCHED=3Dy
> -CONFIG_SECCOMP=3Dy
> -CONFIG_SECURITY=3Dy
> -CONFIG_SECURITY_NETWORK=3Dy
> -CONFIG_SECURITY_SELINUX=3Dy
> -CONFIG_SETEND_EMULATION=3Dy
> -CONFIG_STAGING=3Dy
> -CONFIG_SWP_EMULATION=3Dy
> -CONFIG_SYNC=3Dy
> -CONFIG_TUN=3Dy
> -CONFIG_UNIX=3Dy
> -CONFIG_USB_GADGET=3Dy
> -CONFIG_USB_CONFIGFS=3Dy
> -CONFIG_USB_CONFIGFS_F_FS=3Dy
> -CONFIG_USB_CONFIGFS_F_MIDI=3Dy
> -CONFIG_USB_OTG_WAKELOCK=3Dy
> -CONFIG_XFRM_USER=3Dy
> diff --git a/kernel/configs/android-recommended.config b/kernel/configs/a=
ndroid-recommended.config
> deleted file mode 100644
> index e400fbbc8aba..000000000000
> --- a/kernel/configs/android-recommended.config
> +++ /dev/null
> @@ -1,127 +0,0 @@
> -#  KEEP ALPHABETICALLY SORTED
> -# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
> -# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> -# CONFIG_INPUT_MOUSE is not set
> -# CONFIG_LEGACY_PTYS is not set
> -# CONFIG_NF_CONNTRACK_SIP is not set
> -# CONFIG_PM_WAKELOCKS_GC is not set
> -# CONFIG_VT is not set
> -CONFIG_ARM64_SW_TTBR0_PAN=3Dy
> -CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
> -CONFIG_BLK_DEV_DM=3Dy
> -CONFIG_BLK_DEV_LOOP=3Dy
> -CONFIG_BLK_DEV_RAM=3Dy
> -CONFIG_BLK_DEV_RAM_SIZE=3D8192
> -CONFIG_STACKPROTECTOR_STRONG=3Dy
> -CONFIG_COMPACTION=3Dy
> -CONFIG_CPU_SW_DOMAIN_PAN=3Dy
> -CONFIG_DM_CRYPT=3Dy
> -CONFIG_DM_UEVENT=3Dy
> -CONFIG_DM_VERITY=3Dy
> -CONFIG_DM_VERITY_FEC=3Dy
> -CONFIG_DRAGONRISE_FF=3Dy
> -CONFIG_ENABLE_DEFAULT_TRACERS=3Dy
> -CONFIG_EXT4_FS=3Dy
> -CONFIG_EXT4_FS_SECURITY=3Dy
> -CONFIG_FUSE_FS=3Dy
> -CONFIG_GREENASIA_FF=3Dy
> -CONFIG_HIDRAW=3Dy
> -CONFIG_HID_A4TECH=3Dy
> -CONFIG_HID_ACRUX=3Dy
> -CONFIG_HID_ACRUX_FF=3Dy
> -CONFIG_HID_APPLE=3Dy
> -CONFIG_HID_BELKIN=3Dy
> -CONFIG_HID_CHERRY=3Dy
> -CONFIG_HID_CHICONY=3Dy
> -CONFIG_HID_CYPRESS=3Dy
> -CONFIG_HID_DRAGONRISE=3Dy
> -CONFIG_HID_ELECOM=3Dy
> -CONFIG_HID_EMS_FF=3Dy
> -CONFIG_HID_EZKEY=3Dy
> -CONFIG_HID_GREENASIA=3Dy
> -CONFIG_HID_GYRATION=3Dy
> -CONFIG_HID_HOLTEK=3Dy
> -CONFIG_HID_KENSINGTON=3Dy
> -CONFIG_HID_KEYTOUCH=3Dy
> -CONFIG_HID_KYE=3Dy
> -CONFIG_HID_LCPOWER=3Dy
> -CONFIG_HID_LOGITECH=3Dy
> -CONFIG_HID_LOGITECH_DJ=3Dy
> -CONFIG_HID_MAGICMOUSE=3Dy
> -CONFIG_HID_MICROSOFT=3Dy
> -CONFIG_HID_MONTEREY=3Dy
> -CONFIG_HID_MULTITOUCH=3Dy
> -CONFIG_HID_NTRIG=3Dy
> -CONFIG_HID_ORTEK=3Dy
> -CONFIG_HID_PANTHERLORD=3Dy
> -CONFIG_HID_PETALYNX=3Dy
> -CONFIG_HID_PICOLCD=3Dy
> -CONFIG_HID_PRIMAX=3Dy
> -CONFIG_HID_PRODIKEYS=3Dy
> -CONFIG_HID_ROCCAT=3Dy
> -CONFIG_HID_SAITEK=3Dy
> -CONFIG_HID_SAMSUNG=3Dy
> -CONFIG_HID_SMARTJOYPLUS=3Dy
> -CONFIG_HID_SONY=3Dy
> -CONFIG_HID_SPEEDLINK=3Dy
> -CONFIG_HID_SUNPLUS=3Dy
> -CONFIG_HID_THRUSTMASTER=3Dy
> -CONFIG_HID_TIVO=3Dy
> -CONFIG_HID_TOPSEED=3Dy
> -CONFIG_HID_TWINHAN=3Dy
> -CONFIG_HID_UCLOGIC=3Dy
> -CONFIG_HID_WACOM=3Dy
> -CONFIG_HID_WALTOP=3Dy
> -CONFIG_HID_WIIMOTE=3Dy
> -CONFIG_HID_ZEROPLUS=3Dy
> -CONFIG_HID_ZYDACRON=3Dy
> -CONFIG_INPUT_EVDEV=3Dy
> -CONFIG_INPUT_GPIO=3Dy
> -CONFIG_INPUT_JOYSTICK=3Dy
> -CONFIG_INPUT_MISC=3Dy
> -CONFIG_INPUT_TABLET=3Dy
> -CONFIG_INPUT_UINPUT=3Dy
> -CONFIG_JOYSTICK_XPAD=3Dy
> -CONFIG_JOYSTICK_XPAD_FF=3Dy
> -CONFIG_JOYSTICK_XPAD_LEDS=3Dy
> -CONFIG_KALLSYMS_ALL=3Dy
> -CONFIG_KSM=3Dy
> -CONFIG_LOGIG940_FF=3Dy
> -CONFIG_LOGIRUMBLEPAD2_FF=3Dy
> -CONFIG_LOGITECH_FF=3Dy
> -CONFIG_MD=3Dy
> -CONFIG_MEDIA_SUPPORT=3Dy
> -CONFIG_MSDOS_FS=3Dy
> -CONFIG_PANIC_TIMEOUT=3D5
> -CONFIG_PANTHERLORD_FF=3Dy
> -CONFIG_PERF_EVENTS=3Dy
> -CONFIG_PM_DEBUG=3Dy
> -CONFIG_PM_RUNTIME=3Dy
> -CONFIG_PM_WAKELOCKS_LIMIT=3D0
> -CONFIG_POWER_SUPPLY=3Dy
> -CONFIG_PSTORE=3Dy
> -CONFIG_PSTORE_CONSOLE=3Dy
> -CONFIG_PSTORE_RAM=3Dy
> -CONFIG_SCHEDSTATS=3Dy
> -CONFIG_SMARTJOYPLUS_FF=3Dy
> -CONFIG_SND=3Dy
> -CONFIG_SOUND=3Dy
> -CONFIG_STRICT_KERNEL_RWX=3Dy
> -CONFIG_SUSPEND_TIME=3Dy
> -CONFIG_TABLET_USB_ACECAD=3Dy
> -CONFIG_TABLET_USB_AIPTEK=3Dy
> -CONFIG_TABLET_USB_HANWANG=3Dy
> -CONFIG_TABLET_USB_KBTAB=3Dy
> -CONFIG_TASKSTATS=3Dy
> -CONFIG_TASK_DELAY_ACCT=3Dy
> -CONFIG_TASK_IO_ACCOUNTING=3Dy
> -CONFIG_TASK_XACCT=3Dy
> -CONFIG_TIMER_STATS=3Dy
> -CONFIG_TMPFS=3Dy
> -CONFIG_TMPFS_POSIX_ACL=3Dy
> -CONFIG_UHID=3Dy
> -CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy
> -CONFIG_USB_EHCI_HCD=3Dy
> -CONFIG_USB_HIDDEV=3Dy
> -CONFIG_USB_USBNET=3Dy
> -CONFIG_VFAT_FS=3Dy
> --
> 2.40.0.577.gac1e443424-goog
>
