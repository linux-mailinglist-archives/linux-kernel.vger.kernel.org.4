Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E96704101
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244832AbjEOWfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjEOWfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:35:00 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DF57A98;
        Mon, 15 May 2023 15:34:49 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 62BCA5C0443;
        Mon, 15 May 2023 18:34:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 May 2023 18:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1684190087; x=1684276487; bh=fKjJXgRuqOv1VpJiu2ab6G7x75PW7fSUZ5w
        ezQmsXYo=; b=aU7+bqTQ15+/i10Cd+IJYxZbwzfudjNjAnRJJodBnVqABOyGn9N
        qNNwtN3WdE+0PNJtBJna+w7ttA/JuODyJ876ff8vetquBpP6nFbKabvAnSrHN0/z
        /V7O3zzHcaAcjNsCVuuemj8XJ8ClrnSk26DoKq96nSZYjblMHjJo0Av3b1+tTPT3
        Xa+xntOdE49eb4x5UngXLi0QEM3FEqJjKN7tNGJcdWboAz3pE8kTiJmbi6Un57hz
        QK7vxv9KjBRb0x0wtQ38x5nXtcKfvnHxmSRnGHCUnzFyvPwCEz0f7L29TydnhrFj
        iW6WH9Cq+Y8YId0z0CAjaWq1C9+72paQALQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684190087; x=1684276487; bh=fKjJXgRuqOv1VpJiu2ab6G7x75PW7fSUZ5w
        ezQmsXYo=; b=YpKnWbsV9e8ymC6LUz2hraIsahHhthqWRzBItJqZi9St2hNpphx
        6TcOj4PhG0xc1hcSlmUaIBrPIqnSeyROxKDYlPRMHz8cXh/zmXJCteC3UQDmOlqe
        9sC4ekAduD+JJRRy09oQaiJnUdjN3EXBN5MdO67ZlneCkYx2foY24BTGT0TH07WO
        D2D7vDd51yCYi/V2hnFpOO4EJ2HdXcmejdG4kYub/Ff3VJfV1+KuVBwKdGpgeF8q
        nEYIrv+PB2OntE7DHL6AdxdsAw8aGAc1Dkvmr3pJKh6zRdBwf+qFOQ2BGD1xEuYP
        Xx++ncbwrBiFiYbYYO6vrQmlok3UGclZHcQ==
X-ME-Sender: <xms:hrNiZKlg5fxkyH8SBHNGdPvppqCriKA1JPvnZxPo5EHfpNQuh4qxOg>
    <xme:hrNiZB0aRLR3ChLVbTdftYWusFPxkY5TAFsHZufBfoIFikb8ze_YA9yBN6Zflm6yp
    8y1Ynz3VkFFjiXZsT4>
X-ME-Received: <xmr:hrNiZIqEkSDQO7LPcUD_npqOCDSf9n_eL0Vfkrfn8fNlanBNCVDoPI_9rqVX2DntsS-uEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehkedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgfgsehtqhertdertddunecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpeetteeigefhteffhfevgfffueejffevteffueekhfevjeethefhgfekffevjeehheen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:hrNiZOnWJLsWFx0wtzOzWt8qzAZwnludCMGOR2k8pbrlh2-Wl5HxkA>
    <xmx:hrNiZI2b1DAGBUIpmCw4yRoWgThz46AUHTk6X_jHfBpP8KSJkezD8Q>
    <xmx:hrNiZFuFKftzocOlnxKGr36832f2jJCus0QsrlD2bY5R4C80tYPljg>
    <xmx:h7NiZJllDPXeDUZ9yHcIJ3V6YJDqFtntieH83wtEplSSH9v-T_NcFg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 May 2023 18:34:40 -0400 (EDT)
Date:   Tue, 16 May 2023 10:34:27 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v2 0/1] platform/x86: asus-wmi: add support for ASUS
 screenpad
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     platform-driver-x86@vger.kernel.org,
        =?iso-8859-2?q?Barnab=E1s_P=F5cze?= <pobrn@protonmail.com>,
        Ilpo =?iso-8859-1?q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net,
        corentin.chary@gmail.com, markgross@kernel.org, jdelvare@suse.com,
        linux@roeck-us.net
Message-Id: <FD1QUR.SO09CWU6HM4Q1@ljones.dev>
In-Reply-To: <02f28fe4-bca4-f9d7-a9be-0f1999662d62@redhat.com>
References: <20230505043013.2622603-1-luke@ljones.dev>
        <4be2cc57-59b9-24e2-fd10-f2af175ff518@redhat.com>
        <02f28fe4-bca4-f9d7-a9be-0f1999662d62@redhat.com>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, May 15 2023 at 14:39:10 +0200, Hans de Goede=20
<hdegoede@redhat.com> wrote:
> Hi,
>=20
> On 5/6/23 13:52, Hans de Goede wrote:
>>  Hi Luke,
>>=20
>>  On 5/5/23 06:30, Luke D. Jones wrote:
>>>  Adds support for the screenpad(-plus) found on a few ASUS laptops=20
>>> that have a main 16:9 or 16:10 screen and a shorter screen below=20
>>> the main but above the keyboard.
>>>  The support consists of:
>>>  - On off control
>>>  - Setting brightness from 0-255
>>>=20
>>>  There are some small quirks with this device when considering only=20
>>> the raw WMI methods:
>>>  1. The Off method can only switch the device off
>>>  2. Changing the brightness turns the device back on
>>>  3. To turn the device back on the brightness must be > 1
>>>  4. When the device is off the brightness can't be changed (so it=20
>>> is stored by the driver if device is off).
>>>  5. Booting with a value of 0 brightness (retained by bios) means=20
>>> the bios will set a value of > 0, < 15 which is far too dim and was=20
>>> unexpected by testers. The compromise was to set the brightness to=20
>>> 60 which is a usable brightness if the module init brightness was=20
>>> under 15.
>>>  6. When the device is off it is "unplugged"
>>>=20
>>>  All of the above points are addressed within the patch to create a=20
>>> good user experience and keep within user expectations.
>>>=20
>>>  Changelog:
>>>  - V2
>>>    - Complete refactor to use as a backlight device
>>=20
>>  Thank you on your work for this.
>>=20
>>  Unfortunately I did not get a chance to react to the v1 posting and
>>  the remarks to switch to using /sys/class/backlight there before you
>>  posted this v2.
>>=20
>>  Technically the remark to use /sys/class/backlight for this is
>>  completely correct. But due to the way how userspace uses
>>  /sys/class/backlight this is a problematic.
>>=20
>>  Userspace basically always assumes there is only 1 LCD panel
>>  and it then looks at /sys/class/backlight and picks 1
>>  /sys/class/backlight entry and uses that for the brightness
>>  slider in the desktop-environment UI / system-menu as well
>>  as to handle brightness up/down keyboard hotkey presses.
>>=20

IMO, desktops need to adjust this expectation and start offering=20
controls for all possible screens. This would open up the possibility=20
of setting brightness of modern external screens also. And then they=20
should use the "Primary display" brightness controls, or at least offer=20
an option to set which is controlled.

>>=20
>>  In the (recent) past the kernel used to register e.g.
>>  both /sys/class/backlight/acpi_video0 and
>>  /sys/class/backlight/intel_backlight
>>=20
>>  For ACPI resp. direct hw control of the LCD panel backlight
>>  (so both control the same backlight, sometimes both work
>>  sometimes only 1 works).
>>=20
>>  Userspace uses the backlight-type to determine which backlight
>>  class to use, using (for GNOME, but I believe everywhere) the
>>  following preference order:
>>=20
>>  1. First look for "firmware" type backlight devices (like=20
>> acpi_video0)
>>  2. Then try "platform" type backlight devices
>>  3. Last try "raw" type backlight devices
>>=20
>>  And to make things work the kernel has been hiding the "acpi_video0"
>>  entry in cases where it is known that we need the "raw" aka native
>>  type backlight.
>>=20
>>  Luke you seem to already be partly aware of this, because the patch
>>  now has this:
>>=20
>>  	props.type =3D BACKLIGHT_RAW; /* ensure this bd is last to be picked=20
>> */
>>=20
>>  but almost all modern laptops exclusively use the raw/native type
>>  for backlight control of the main LCD panel.
>>=20
>>  So now we end up with 2 "raw" type backlight devices and if
>>  e.g. gnome-settings-daemon picks the right one now sort of
>>  is left to luck.
>>=20

In a test KDE at least picked the right one.

>>=20
>>  Well that is not entirely true, at least gnome-settings-daemon
>>  prefers raw backlight devices where the parent has an "enabled"
>>  sysfs attribute (it expects the parent to be a drm_connector
>>  object) and where that enabled attribute reads as "enabled".
>>=20

Ah I see. Parent for screenpad is "platform", while the main is on igpu=20
with parent "pci". I will paste some udev info at the end of this reply.

>>=20
>>  This is done for hybrid-gfx laptops where there already may
>>  be 2 raw backlight-class devices, 1 for each GPU but only
>>  1 of the 2 drm_connectors going to the main LCD panel should
>>  actually show as enabled.
>>=20
>>  So typing all this out I guess we could go ahead with using
>>  the backlight class for this after all, but this relies
>>  on userspace preferring raw backlight-class devices
>>  with a drm_connector-object parent which show as being
>>  enabled.
>>=20
>>  Any userspace code which does not do the parent has
>>  an enabled attr reading "enabled" or a similar check
>>  will end up picking a random backlight class device
>>  as control for the main panel brightness which will not
>>  always end well. So this all is a bit fragile ...
>>=20
>>  And I'm not sure what is the best thing to do here.
>>=20
>>  Barnab=E1s, Ilpo, Guenter, any comments on this ?
>=20
> Hmm, no comments from anyone on the potential problems of using
> /sys/class/backlight for this causing potential userspace confusion
> since normally /sys/class/backlight devices control the main LCD
> brightness ?
>=20
> Luke do you have any thoughts on this yourself ?
>=20
> And can you answer this question please ?  :
>=20
>>  Luke, question how does the second/exta panel look
>>  from an outputting video to it pov ?  Does it show
>>  up as an extra screen connected to a drm_connector
>>  on one of the GPUs. IOW can it be used with standard
>>  kernel-modesetting APIs ?
>=20

Hi Hans, sorry about delay in response, just been tied up with work.

As I don't actually have this kind of laptop I can't easily get info,=20
but I can ask a few people in my discord for information. Is there=20
anything in particular you would need to know? From my basic=20
understanding some of the points are:

1. It does show as an actual additional screen
2. Internal wiring is unclear, when dispaly MUX is switched to dgpu the=20
screen is still detected but not drawn to
3. Point 2 is actually more uncertain as it seems only wayland had this=20
issue? I will get more info.

So I think now is probably a good time to raise a particular issue I've=20
encountered with the last two years: the display MUX.

As I understand it now, there are two types of new MUX - the manual=20
switch, and the newer "Advanced Optimus" automatic switch. The issues I=20
have are with the manual switch since I've not encountered the advanced=20
optimus yet.

When the switch is. uh. switched. the dgpu drives the internal display,=20
and I expect that since the display is now detected through the dgpu,=20
this is why the dgpu is kept awake to drive it. But, the igpu is also=20
still active, and because of this the initial boot from grub to=20
display-manager is a black screen including tty. This means anyone with=20
an encrypted drive will never see the prompt and they believe they have=20
a failed boot. I don't know what to do about this?

What I would love is somehow to either disable the igpu in kernel if=20
the MUX is toggled, or to change which device is the primary. Do you=20
have any thoughts on where I should start on this?

An additional problem: `boot_vga` property of display adaptors. I've=20
been using this as a first-stage check in supergfxctl to determine if=20
there was a switch, but it is never ever reliable - sometimes it=20
changes, sometimes it is entirely blank (using udev to fetch=20
properties). And then I need to use a combination of checks to=20
determine state. So this `boot_vga` seems to always be available but is=20
practically unusable.



UDEV info dumps:

Device {
    initialized: true,
    device_major_minor_number: None,
    system_path:=20
"/sys/devices/pci0000:00/0000:00:08.1/0000:09:00.0/backlight/amdgpu_bl1",
    device_path:=20
"/devices/pci0000:00/0000:00:08.1/0000:09:00.0/backlight/amdgpu_bl1",
    device_node: None,
    subsystem_name: Some(
        "backlight",
    ),
    system_name: "amdgpu_bl1",
    instance_number: Some(
        1,
    ),
    device_type: None,
    driver: None,
    action: None,
    parent: Some(
        Device {
            initialized: true,
            device_major_minor_number: None,
            system_path:=20
"/sys/devices/pci0000:00/0000:00:08.1/0000:09:00.0",
            device_path:=20
"/devices/pci0000:00/0000:00:08.1/0000:09:00.0",
            device_node: None,
            subsystem_name: Some(
                "pci",
            ),
            system_name: "0000:09:00.0",
            instance_number: Some(
                0,
            ),
            device_type: None,
            driver: Some(
                "amdgpu",
            ),
            action: None,
            parent: Some(
                Device {
                    initialized: true,
                    device_major_minor_number: None,
                    system_path: "/sys/devices/pci0000:00/0000:00:08.1",
                    device_path: "/devices/pci0000:00/0000:00:08.1",
                    device_node: None,
                    subsystem_name: Some(
                        "pci",
                    ),
                    system_name: "0000:00:08.1",
                    instance_number: Some(
                        1,
                    ),
                    device_type: None,
                    driver: Some(
                        "pcieport",
                    ),
                    action: None,
                    parent: Some(
                        Device {
                            initialized: false,
                            device_major_minor_number: None,
                            system_path: "/sys/devices/pci0000:00",
                            device_path: "/devices/pci0000:00",
                            device_node: None,
                            subsystem_name: None,
                            system_name: "pci0000:00",
                            instance_number: Some(
                                0,
                            ),
                            device_type: None,
                            driver: None,
                            action: None,
                            parent: None,
                        },
                    ),
                },
            ),
        },
    ),
}
  [properties]
    - "CURRENT_TAGS" ":systemd:seat:"
    - "DEVPATH"=20
"/devices/pci0000:00/0000:00:08.1/0000:09:00.0/backlight/amdgpu_bl1"
    - "DMI_FAMILY" "ROG Zephyrus Duo 16"
    - "DMI_VENDOR" "ASUSTeK COMPUTER INC."
    - "ID_FOR_SEAT" "backlight-pci-0000_09_00_0"
    - "ID_PATH" "pci-0000:09:00.0"
    - "ID_PATH_TAG" "pci-0000_09_00_0"
    - "NVME_HOST_IFACE" "none"
    - "SUBSYSTEM" "backlight"
    - "SYSTEMD_WANTS" "systemd-backlight@backlight:amdgpu_bl1.service"
    - "TAGS" ":systemd:seat:"
    - "USEC_INITIALIZED" "6189554"
  [attributes]
    - "actual_brightness" ""
    - "bl_power" ""
    - "brightness" ""
    - "device" ""
    - "max_brightness" ""
    - "power/autosuspend_delay_ms" ""
    - "power/control" ""
    - "power/runtime_active_time" ""
    - "power/runtime_status" ""
    - "power/runtime_suspended_time" ""
    - "scale" ""
    - "subsystem" ""
    - "type" ""
    - "uevent" ""

Device {
    initialized: true,
    device_major_minor_number: None,
    system_path:=20
"/sys/devices/platform/asus-nb-wmi/backlight/asus_screenpad",
    device_path:=20
"/devices/platform/asus-nb-wmi/backlight/asus_screenpad",
    device_node: None,
    subsystem_name: Some(
        "backlight",
    ),
    system_name: "asus_screenpad",
    instance_number: None,
    device_type: None,
    driver: None,
    action: None,
    parent: Some(
        Device {
            initialized: true,
            device_major_minor_number: None,
            system_path: "/sys/devices/platform/asus-nb-wmi",
            device_path: "/devices/platform/asus-nb-wmi",
            device_node: None,
            subsystem_name: Some(
                "platform",
            ),
            system_name: "asus-nb-wmi",
            instance_number: None,
            device_type: None,
            driver: Some(
                "asus-nb-wmi",
            ),
            action: None,
            parent: Some(
                Device {
                    initialized: false,
                    device_major_minor_number: None,
                    system_path: "/sys/devices/platform",
                    device_path: "/devices/platform",
                    device_node: None,
                    subsystem_name: None,
                    system_name: "platform",
                    instance_number: None,
                    device_type: None,
                    driver: None,
                    action: None,
                    parent: None,
                },
            ),
        },
    ),
}
  [properties]
    - "CURRENT_TAGS" ":systemd:seat:"
    - "DEVPATH" "/devices/platform/asus-nb-wmi/backlight/asus_screenpad"
    - "DMI_FAMILY" "ROG Zephyrus Duo 16"
    - "DMI_VENDOR" "ASUSTeK COMPUTER INC."
    - "ID_FOR_SEAT" "backlight-platform-asus-nb-wmi"
    - "ID_PATH" "platform-asus-nb-wmi"
    - "ID_PATH_TAG" "platform-asus-nb-wmi"
    - "NVME_HOST_IFACE" "none"
    - "SUBSYSTEM" "backlight"
    - "SYSTEMD_WANTS"=20
"systemd-backlight@backlight:asus_screenpad.service"
    - "TAGS" ":systemd:seat:"
    - "USEC_INITIALIZED" "6323833"
  [attributes]
    - "actual_brightness" ""
    - "bl_power" ""
    - "brightness" ""
    - "device" ""
    - "max_brightness" ""
    - "power/autosuspend_delay_ms" ""
    - "power/control" ""
    - "power/runtime_active_time" ""
    - "power/runtime_status" ""
    - "power/runtime_suspended_time" ""
    - "scale" ""
    - "subsystem" ""
    - "type" ""
    - "uevent" ""


Device {
    initialized: true,
    device_major_minor_number: None,
    system_path:=20
"/sys/devices/pci0000:00/0000:00:08.1/0000:09:00.0/drm/card1/card1-DP-1",
    device_path:=20
"/devices/pci0000:00/0000:00:08.1/0000:09:00.0/drm/card1/card1-DP-1",
    device_node: None,
    subsystem_name: Some(
        "drm",
    ),
    system_name: "card1-DP-1",
    instance_number: Some(
        1,
    ),
    device_type: Some(
        "drm_connector",
    ),
    driver: None,
    action: None,
    parent: Some(
        Device {
            initialized: true,
            device_major_minor_number: Some(
                57857,
            ),
            system_path:=20
"/sys/devices/pci0000:00/0000:00:08.1/0000:09:00.0/drm/card1",
            device_path:=20
"/devices/pci0000:00/0000:00:08.1/0000:09:00.0/drm/card1",
            device_node: Some(
                "/dev/dri/card1",
            ),
            subsystem_name: Some(
                "drm",
            ),
            system_name: "card1",
            instance_number: Some(
                1,
            ),
            device_type: Some(
                "drm_minor",
            ),
            driver: None,
            action: None,
            parent: Some(
                Device {
                    initialized: true,
                    device_major_minor_number: None,
                    system_path:=20
"/sys/devices/pci0000:00/0000:00:08.1/0000:09:00.0",
                    device_path:=20
"/devices/pci0000:00/0000:00:08.1/0000:09:00.0",
                    device_node: None,
                    subsystem_name: Some(
                        "pci",
                    ),
                    system_name: "0000:09:00.0",
                    instance_number: Some(
                        0,
                    ),
                    device_type: None,
                    driver: Some(
                        "amdgpu",
                    ),
                    action: None,
                    parent: Some(
                        Device {
                            initialized: true,
                            device_major_minor_number: None,
                            system_path:=20
"/sys/devices/pci0000:00/0000:00:08.1",
                            device_path:=20
"/devices/pci0000:00/0000:00:08.1",
                            device_node: None,
                            subsystem_name: Some(
                                "pci",
                            ),
                            system_name: "0000:00:08.1",
                            instance_number: Some(
                                1,
                            ),
                            device_type: None,
                            driver: Some(
                                "pcieport",
                            ),
                            action: None,
                            parent: Some(
                                Device {
                                    initialized: false,
                                    device_major_minor_number: None,
                                    system_path:=20
"/sys/devices/pci0000:00",
                                    device_path: "/devices/pci0000:00",
                                    device_node: None,
                                    subsystem_name: None,
                                    system_name: "pci0000:00",
                                    instance_number: Some(
                                        0,
                                    ),
                                    device_type: None,
                                    driver: None,
                                    action: None,
                                    parent: None,
                                },
                            ),
                        },
                    ),
                },
            ),
        },
    ),
}
  [properties]
    - "CURRENT_TAGS" ":master-of-seat:seat:"
    - "DEVPATH"=20
"/devices/pci0000:00/0000:00:08.1/0000:09:00.0/drm/card1/card1-DP-1"
    - "DEVTYPE" "drm_connector"
    - "DMI_FAMILY" "ROG Zephyrus Duo 16"
    - "DMI_VENDOR" "ASUSTeK COMPUTER INC."
    - "ID_FOR_SEAT" "drm-pci-0000_09_00_0"
    - "ID_PATH" "pci-0000:09:00.0"
    - "ID_PATH_TAG" "pci-0000_09_00_0"
    - "SUBSYSTEM" "drm"
    - "TAGS" ":master-of-seat:seat:"
    - "USEC_INITIALIZED" "6196005"
  [attributes]
    - "ddc" ""
    - "device" ""
    - "dpms" ""
    - "edid" ""
    - "enabled" ""
    - "modes" ""
    - "power/autosuspend_delay_ms" ""
    - "power/control" ""
    - "power/runtime_active_time" ""
    - "power/runtime_status" ""
    - "power/runtime_suspended_time" ""
    - "status" ""
    - "subsystem" ""
    - "uevent" ""
>=20


