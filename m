Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5AD68240A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 06:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjAaFco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 00:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjAaFcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 00:32:20 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1A41DBAB;
        Mon, 30 Jan 2023 21:32:15 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id cf42so22595507lfb.1;
        Mon, 30 Jan 2023 21:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QZFo8Db1DELpP3PggDa39ncTgche8KwZ1+RaAo+FkPo=;
        b=SmOAZMMLAF1gkDs8NCaIpOvq/hbPmRuGuTh9v/Y26PF11eF++GH1zZBuunVcPQmwd4
         S99ex5ndQLT7tZhjZq5R1KB/eDkhoq18H+vqKyFXYfaZ5XqWP5id//4/XfvkppQUg1Qo
         QrrTsoIxFgMw8+PeG4hmWxKte9MCf92acI94EWBg8wzWROPyfAeW5PtBtohGeBuogvHv
         l7U8nw5rhxmWrByo5yAjNvhWtllNoum0BWr/Pc1lQZexgAu3HbNwqB58sZFy3xF/TNRw
         vHABSAQM+bFuhjhZqR3JH4cJAhpJXGQygVWDfagyZ7Gyud3ZR+s3AIl9FTFZ8hBqBafJ
         NKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZFo8Db1DELpP3PggDa39ncTgche8KwZ1+RaAo+FkPo=;
        b=pq1lunbZHHcfFQbVIubTItP7wAsxkXQU79SY1CbAN6D0+SAqTrm5y3kij2s1twQ53Q
         5VsdqBTJZVo6QU0wBDi2dVgHQfjudjTxjh/7yGzHF+tn8l4mL8EwFqvuvp6g3khdBJKP
         Nk3M+ERICyMQyPEFUj0BwAkTUesXdA3qj9J/6rOBUVEDN8fROcR43aJExJaMTx1gSYVw
         cTPMzUzC7t8EfxmbT4YtGWMo7sCppLRAx8vlWCxW/gEFaVciDqFLLaLezskTIt4GuDxU
         tdEy8B4hI1RldZIMKgd6I/7JtEpK1CgUF4dmLp+tefBxmG2v1zabEUGYYmW0kCqtsMrd
         Akrg==
X-Gm-Message-State: AFqh2kpSHGQ63C4goLt9qbQ5OVtndUp2SZQLOuTRRofhyQf+9omMbUfA
        ExYND6PYqY4insJoUyCRQVzNj/yQkfYL3bGUXWv+m7wxsNEFbl4w
X-Google-Smtp-Source: AMrXdXveUz7wjOxoHwrp0H59dQ1oMLROUXyYadwlIOAVvdYURTTlBFJsDdDiXP46fILQYBYnhcO475oNCXSHk6o1VSY=
X-Received: by 2002:a05:6512:34cb:b0:4cb:ce4:7bf0 with SMTP id
 w11-20020a05651234cb00b004cb0ce47bf0mr6699010lfr.78.1675143133275; Mon, 30
 Jan 2023 21:32:13 -0800 (PST)
MIME-Version: 1.0
References: <2667007.mvXUDI8C0e@kreacher>
In-Reply-To: <2667007.mvXUDI8C0e@kreacher>
From:   Swift Geek <swiftgeek@gmail.com>
Date:   Tue, 31 Jan 2023 06:31:14 +0100
Message-ID: <CAO0qwq0FKkhUkimOb3QLb4w3hcb3XrLSFxgvZ_oqOyJeZHm96w@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Drop the custom_method debugfs interface
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Hang Zhang <zh.nvgt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 5:26 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The ACPI custom_method debugfs interface is security-sensitive and
> concurrent access to it is broken [1].
>
> Moreover, the recipe for preparing a customized version of a given
> control method has changed at one point due to ACPICA changes, which
> has not been reflected in its documentation, so whoever used it before
> has had to adapt an no problems with it have been reported.
>
> The latter likely means that the number of its users is limited at best
> and attempting to fix the issues mentioned above is likely not worth the
> effort.  Moreover, if it gets broken in the process, the breakage may not
> be readily discovered, so deleting it altogheher appeares to be a better
> option.
>
> Accordingly, drop custom_method along with its (outdated anyway)
> documentation.
>
> Link: https://lore.kernel.org/linux-acpi/20221227063335.61474-1-zh.nvgt@gmail.com/ # [1]
> Reported-by: Hang Zhang <zh.nvgt@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Sample on iasl "20220331", and thinkpad X200 running coreboot, for
easy reference

test.dsl created according to existing linux docs (ie. by providing
full path to `_Q26`):

DefinitionBlock ("", "DSDT", 2, "COREv4", "COREBOOT", 0x20090419)
{
        Method (\_SB.PCI0.LPCB.EC._Q26, 0, NotSerialized)  // _Qxx: EC
Query, xx=0x00-0xFF
        {
                Printf ("_Q26 FUN!")
                Notify (AC, 0x80) // Status Change
                PNOT ()
        }
}

`iasl test.dsl`
`iasl -vw 6084 test.dsl`
`iasl -vw 6084 -vw 6160 test.dsl`

Neither of those combinations make any difference in output `test.aml` binary.
With slightly newer iasl "20221020" we have to ignore errors, just
like original document describes. Still works fine with `iasl -vw 6084
-vw 6160 test.dsl`
`iasl -h` is pretty clear about '-vw' being used to ignore particular
error messages, so I really see no substantial change here.

modprobe custom_method
cat test.aml > /sys/kernel/debug/acpi/custom_method
echo 1 > /sys/module/acpi/parameters/aml_debug_output

Now upon each connection of AC power brick to lappy, I get following
message in dmesg:
[  699.784020] ACPI Debug:  "_Q26 FUN!"

Latest tested and working linux kernel: 6.1
Sorry for not testing writing acpi stuff on 6.2-rc6 kernel

It's sad to see custom_method go, since it lives under debugfs and you
have to specifically build this, so I don't see it as a security
issue.
When I write/troubleshoot DSDT I do it alone, and I do not think that
there is a machine for which people developed DSDT concurrently while
being connected to same machine, with root access, swapping DSDT table
at the same time. It works for me great, and I presume it does so for
other embed developers.

I guess it's possible to create replacement workflow with kexec and
entire table load via CONFIG_ACPI_TABLE_UPGRADE, but note how it would
be more difficult and more things could go wrong. Swapping out just
single method even when machine has significant uptime feels like a
great thing I had with custom_method (like just when some rare
condition started occurring).

Anyway I get that maintenance burden is too great for this portion of
kernel, and obscure use cases of a firmware developer writing DSDT are
not a priority. I'm not smart enough to maintain it, so I guess I need
to say my goodbyes to this fun part of the kernel. Thanks to everyone
that kept it going for this long.

Sebastian Grzywna

> ---
>
> -> v2: Update index.rst too.
>
> ---
>  Documentation/firmware-guide/acpi/index.rst              |    1
>  Documentation/firmware-guide/acpi/method-customizing.rst |   89 ------------
>  drivers/acpi/Kconfig                                     |   14 --
>  drivers/acpi/Makefile                                    |    1
>  drivers/acpi/custom_method.c                             |  103 ---------------
>  5 files changed, 208 deletions(-)
>
> Index: linux-pm/drivers/acpi/Kconfig
> ===================================================================
> --- linux-pm.orig/drivers/acpi/Kconfig
> +++ linux-pm/drivers/acpi/Kconfig
> @@ -444,20 +444,6 @@ config ACPI_HED
>           which is used to report some hardware errors notified via
>           SCI, mainly the corrected errors.
>
> -config ACPI_CUSTOM_METHOD
> -       tristate "Allow ACPI methods to be inserted/replaced at run time"
> -       depends on DEBUG_FS
> -       help
> -         This debug facility allows ACPI AML methods to be inserted and/or
> -         replaced without rebooting the system. For details refer to:
> -         Documentation/firmware-guide/acpi/method-customizing.rst.
> -
> -         NOTE: This option is security sensitive, because it allows arbitrary
> -         kernel memory to be written to by root (uid=0) users, allowing them
> -         to bypass certain security measures (e.g. if root is not allowed to
> -         load additional kernel modules after boot, this feature may be used
> -         to override that restriction).
> -
>  config ACPI_BGRT
>         bool "Boottime Graphics Resource Table support"
>         depends on EFI && (X86 || ARM64)
> Index: linux-pm/drivers/acpi/Makefile
> ===================================================================
> --- linux-pm.orig/drivers/acpi/Makefile
> +++ linux-pm/drivers/acpi/Makefile
> @@ -101,7 +101,6 @@ obj-$(CONFIG_ACPI_SBS)              += sbshc.o
>  obj-$(CONFIG_ACPI_SBS)         += sbs.o
>  obj-$(CONFIG_ACPI_HED)         += hed.o
>  obj-$(CONFIG_ACPI_EC_DEBUGFS)  += ec_sys.o
> -obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
>  obj-$(CONFIG_ACPI_BGRT)                += bgrt.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)    += cppc_acpi.o
>  obj-$(CONFIG_ACPI_SPCR_TABLE)  += spcr.o
> Index: linux-pm/drivers/acpi/custom_method.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/custom_method.c
> +++ /dev/null
> @@ -1,103 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * custom_method.c - debugfs interface for customizing ACPI control method
> - */
> -
> -#include <linux/init.h>
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/uaccess.h>
> -#include <linux/debugfs.h>
> -#include <linux/acpi.h>
> -#include <linux/security.h>
> -
> -#include "internal.h"
> -
> -MODULE_LICENSE("GPL");
> -
> -static struct dentry *cm_dentry;
> -
> -/* /sys/kernel/debug/acpi/custom_method */
> -
> -static ssize_t cm_write(struct file *file, const char __user *user_buf,
> -                       size_t count, loff_t *ppos)
> -{
> -       static char *buf;
> -       static u32 max_size;
> -       static u32 uncopied_bytes;
> -
> -       struct acpi_table_header table;
> -       acpi_status status;
> -       int ret;
> -
> -       ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
> -       if (ret)
> -               return ret;
> -
> -       if (!(*ppos)) {
> -               /* parse the table header to get the table length */
> -               if (count <= sizeof(struct acpi_table_header))
> -                       return -EINVAL;
> -               if (copy_from_user(&table, user_buf,
> -                                  sizeof(struct acpi_table_header)))
> -                       return -EFAULT;
> -               uncopied_bytes = max_size = table.length;
> -               /* make sure the buf is not allocated */
> -               kfree(buf);
> -               buf = kzalloc(max_size, GFP_KERNEL);
> -               if (!buf)
> -                       return -ENOMEM;
> -       }
> -
> -       if (buf == NULL)
> -               return -EINVAL;
> -
> -       if ((*ppos > max_size) ||
> -           (*ppos + count > max_size) ||
> -           (*ppos + count < count) ||
> -           (count > uncopied_bytes)) {
> -               kfree(buf);
> -               buf = NULL;
> -               return -EINVAL;
> -       }
> -
> -       if (copy_from_user(buf + (*ppos), user_buf, count)) {
> -               kfree(buf);
> -               buf = NULL;
> -               return -EFAULT;
> -       }
> -
> -       uncopied_bytes -= count;
> -       *ppos += count;
> -
> -       if (!uncopied_bytes) {
> -               status = acpi_install_method(buf);
> -               kfree(buf);
> -               buf = NULL;
> -               if (ACPI_FAILURE(status))
> -                       return -EINVAL;
> -               add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
> -       }
> -
> -       return count;
> -}
> -
> -static const struct file_operations cm_fops = {
> -       .write = cm_write,
> -       .llseek = default_llseek,
> -};
> -
> -static int __init acpi_custom_method_init(void)
> -{
> -       cm_dentry = debugfs_create_file("custom_method", S_IWUSR,
> -                                       acpi_debugfs_dir, NULL, &cm_fops);
> -       return 0;
> -}
> -
> -static void __exit acpi_custom_method_exit(void)
> -{
> -       debugfs_remove(cm_dentry);
> -}
> -
> -module_init(acpi_custom_method_init);
> -module_exit(acpi_custom_method_exit);
> Index: linux-pm/Documentation/firmware-guide/acpi/method-customizing.rst
> ===================================================================
> --- linux-pm.orig/Documentation/firmware-guide/acpi/method-customizing.rst
> +++ /dev/null
> @@ -1,89 +0,0 @@
> -.. SPDX-License-Identifier: GPL-2.0
> -
> -=======================================
> -Linux ACPI Custom Control Method How To
> -=======================================
> -
> -:Author: Zhang Rui <rui.zhang@intel.com>
> -
> -
> -Linux supports customizing ACPI control methods at runtime.
> -
> -Users can use this to:
> -
> -1. override an existing method which may not work correctly,
> -   or just for debugging purposes.
> -2. insert a completely new method in order to create a missing
> -   method such as _OFF, _ON, _STA, _INI, etc.
> -
> -For these cases, it is far simpler to dynamically install a single
> -control method rather than override the entire DSDT, because kernel
> -rebuild/reboot is not needed and test result can be got in minutes.
> -
> -.. note::
> -
> -  - Only ACPI METHOD can be overridden, any other object types like
> -    "Device", "OperationRegion", are not recognized. Methods
> -    declared inside scope operators are also not supported.
> -
> -  - The same ACPI control method can be overridden for many times,
> -    and it's always the latest one that used by Linux/kernel.
> -
> -  - To get the ACPI debug object output (Store (AAAA, Debug)),
> -    please run::
> -
> -      echo 1 > /sys/module/acpi/parameters/aml_debug_output
> -
> -
> -1. override an existing method
> -==============================
> -a) get the ACPI table via ACPI sysfs I/F. e.g. to get the DSDT,
> -   just run "cat /sys/firmware/acpi/tables/DSDT > /tmp/dsdt.dat"
> -b) disassemble the table by running "iasl -d dsdt.dat".
> -c) rewrite the ASL code of the method and save it in a new file,
> -d) package the new file (psr.asl) to an ACPI table format.
> -   Here is an example of a customized \_SB._AC._PSR method::
> -
> -      DefinitionBlock ("", "SSDT", 1, "", "", 0x20080715)
> -      {
> -         Method (\_SB_.AC._PSR, 0, NotSerialized)
> -         {
> -            Store ("In AC _PSR", Debug)
> -            Return (ACON)
> -         }
> -      }
> -
> -   Note that the full pathname of the method in ACPI namespace
> -   should be used.
> -e) assemble the file to generate the AML code of the method.
> -   e.g. "iasl -vw 6084 psr.asl" (psr.aml is generated as a result)
> -   If parameter "-vw 6084" is not supported by your iASL compiler,
> -   please try a newer version.
> -f) mount debugfs by "mount -t debugfs none /sys/kernel/debug"
> -g) override the old method via the debugfs by running
> -   "cat /tmp/psr.aml > /sys/kernel/debug/acpi/custom_method"
> -
> -2. insert a new method
> -======================
> -This is easier than overriding an existing method.
> -We just need to create the ASL code of the method we want to
> -insert and then follow the step c) ~ g) in section 1.
> -
> -3. undo your changes
> -====================
> -The "undo" operation is not supported for a new inserted method
> -right now, i.e. we can not remove a method currently.
> -For an overridden method, in order to undo your changes, please
> -save a copy of the method original ASL code in step c) section 1,
> -and redo step c) ~ g) to override the method with the original one.
> -
> -
> -.. note:: We can use a kernel with multiple custom ACPI method running,
> -   But each individual write to debugfs can implement a SINGLE
> -   method override. i.e. if we want to insert/override multiple
> -   ACPI methods, we need to redo step c) ~ g) for multiple times.
> -
> -.. note:: Be aware that root can mis-use this driver to modify arbitrary
> -   memory and gain additional rights, if root's privileges got
> -   restricted (for example if root is not allowed to load additional
> -   modules after boot).
> Index: linux-pm/Documentation/firmware-guide/acpi/index.rst
> ===================================================================
> --- linux-pm.orig/Documentation/firmware-guide/acpi/index.rst
> +++ linux-pm/Documentation/firmware-guide/acpi/index.rst
> @@ -14,7 +14,6 @@ ACPI Support
>     dsd/phy
>     enumeration
>     osi
> -   method-customizing
>     method-tracing
>     DSD-properties-rules
>     debug
>
>
>
