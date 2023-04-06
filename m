Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2556DA0A7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240299AbjDFTE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjDFTEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:04:50 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E854A1FCE;
        Thu,  6 Apr 2023 12:04:46 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id h198so3473814ybg.12;
        Thu, 06 Apr 2023 12:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680807886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xMnB1BWsXkJrFrB91ycwvIv2li25DlhOFv9Z9iXLAng=;
        b=AETFkZHOqe7lX4Le9wuT+4BaaWa7M2V6q0UrI28gKMjnTDSxPutlovwVUYthtaNk1T
         X53E2xVekDqs+nNM2afvQYHHpKlJ9zHa74cnhk364Rd0CadxMalshv1dJCaHyAsrHXSX
         O73IwbX7Pf95hMIP0eB5uOJOINfBoTDFVZ2wSjIiNTVwiWJ8yviDlrkwsWiCPKNXP1nh
         raUBQCyrLpv3lsbXNJRAfR4xHLOaqx1RcuaN45hjDMIrVn/L6/bHN03Tow3bQazHXGBc
         bBcxbKv3AyqWPDuv7J4PhudIJuZdtvSiw+xnXXAbmsOqcbDb2vJqLKKBk2eKlLMyiNMG
         bBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMnB1BWsXkJrFrB91ycwvIv2li25DlhOFv9Z9iXLAng=;
        b=Mf9x/cXYG9wweB6I/CMRp+er3KpEDHc55OHrZYWs7uammu6zfulAPpe7j6TfhKnGeO
         fiClFVS6NytG/VjoNkeskXjo1TLZ/pJ+DRD4qztBiU+QNMprlVxKIImpMqJ8RDvubA0x
         A0OcV88DahX4RpTybXcsXiNckCPYHtRLh6GM3imOFweHloLtq8E/fBkhaNBn+/8NeqP0
         fw0zbLFVMf5zmA+v/WUkXxgFQX/UtjebU4ts5uBgJjCcnVAdOrcjXait1Rv5PzOn2qZP
         sZftlOf8HIOevxFXwpyvMxZpBcw9fwBdqN3pym6sGCLnHNnItz7vH2e3dYOw9qaMqhJW
         bS3g==
X-Gm-Message-State: AAQBX9eVqxX7HWDT+PW5voeoi3LUGJGVxerUIMSgBqfCVSM75eFeVT+r
        7lxgCbEOIk8Dt5fYekZdUCiwZ+LV/HFKNn1TRyI=
X-Google-Smtp-Source: AKy350aidCpq5rS5bRsmyTpVLnVYbWxw7V2+LKPF4BQXvAtd8XB/3azpzrPJ62fkW5nZ2cM8jy4pCopz3DGttyJada4=
X-Received: by 2002:a25:7b47:0:b0:b1d:5061:98e3 with SMTP id
 w68-20020a257b47000000b00b1d506198e3mr265097ybc.6.1680807885605; Thu, 06 Apr
 2023 12:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230405201416.395840-1-daniel.almeida@collabora.com> <20230405201416.395840-3-daniel.almeida@collabora.com>
In-Reply-To: <20230405201416.395840-3-daniel.almeida@collabora.com>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Thu, 6 Apr 2023 16:04:37 -0300
Message-ID: <CANeycqoh+ePXODJ57UT1UdhHDgzDXr=KoQEo7HiSDJDHha2dsQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: virtio: add virtio support
To:     Daniel Almeida <daniel.almeida@collabora.com>
Cc:     ojeda@kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2023 at 17:14, Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> This patch adds virtIO support to the rust crate. This includes the
> capability to create a virtIO driver (through the module_virtio_driver
> macro and the respective Driver trait) as well as initial virtqueue
> support.
>
> A sample virtIO module is included for conveninence.
>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>  rust/bindings/bindings_helper.h |   3 +
>  rust/helpers.c                  |  25 +++
>  rust/kernel/lib.rs              |   2 +
>  rust/kernel/virtio.rs           | 261 ++++++++++++++++++++++++++++++++
>  rust/kernel/virtio/virtqueue.rs | 126 +++++++++++++++
>  samples/rust/Kconfig            |  10 ++
>  samples/rust/Makefile           |   1 +
>  samples/rust/rust_virtio.rs     | 195 ++++++++++++++++++++++++
>  8 files changed, 623 insertions(+)
>  create mode 100644 rust/kernel/virtio.rs
>  create mode 100644 rust/kernel/virtio/virtqueue.rs
>  create mode 100644 samples/rust/rust_virtio.rs
>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 048bae2197ac..001a492e0554 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -35,6 +35,9 @@
>  #include <linux/sysctl.h>
>  #include <linux/uaccess.h>
>  #include <linux/uio.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio.h>
>
>  /* `bindgen` gets confused at certain things. */
>  const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
> diff --git a/rust/helpers.c b/rust/helpers.c
> index bf790f46c763..a80b0ab8ca64 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -39,6 +39,8 @@
>  #include <linux/skbuff.h>
>  #include <linux/uaccess.h>
>  #include <linux/uio.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
>
>  __noreturn void rust_helper_BUG(void)
>  {
> @@ -655,6 +657,29 @@ int rust_helper_fs_parse(struct fs_context *fc,
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_fs_parse);
>
> +struct virtqueue *rust_helper_virtio_find_single_vq(struct virtio_device *vdev,
> +                                                   vq_callback_t *c,
> +                                                   const char *n)
> +{
> +       return virtio_find_single_vq(vdev, c, n);
> +}
> +
> +EXPORT_SYMBOL_GPL(rust_helper_virtio_find_single_vq);
> +
> +void rust_helper_virtio_del_vqs(struct virtio_device *vdev)
> +{
> +       vdev->config->del_vqs(vdev);
> +}
> +
> +EXPORT_SYMBOL_GPL(rust_helper_virtio_del_vqs);
> +
> +void rust_helper_virtio_device_ready(struct virtio_device *vdev)
> +{
> +       virtio_device_ready(vdev);
> +}
> +
> +EXPORT_SYMBOL_GPL(rust_helper_virtio_device_ready);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index b23be69919cc..5441b545c5f2 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -74,6 +74,8 @@ pub mod revocable;
>  pub mod scatterlist;
>  pub mod security;
>  pub mod task;
> +#[cfg(CONFIG_VIRTIO)]
> +pub mod virtio;
>  pub mod workqueue;
>
>  pub mod linked_list;
> diff --git a/rust/kernel/virtio.rs b/rust/kernel/virtio.rs
> new file mode 100644
> index 000000000000..a95a32605728
> --- /dev/null
> +++ b/rust/kernel/virtio.rs
> @@ -0,0 +1,261 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Virtio abstractions
> +//!
> +//! C header: [`include/linux/virtio.h`](../../../../include/media/virtio.h)
> +
> +use crate::{
> +    device, driver,
> +    error::{self, from_kernel_result},
> +    prelude::*,
> +    str::CStr,
> +    to_result, ForeignOwnable, ThisModule,
> +};
> +
> +pub mod virtqueue;
> +
> +/// A VirtIO Device ID entry. Safe wrapper over `struct virtio_device_id`.
> +#[derive(Copy, Clone, Debug, PartialEq, PartialOrd)]
> +pub struct DeviceId {
> +    /// The device ID in the virtIO protocol.
> +    pub device: u32,
> +    /// The vendor ID, usually set to VIRTIO_DEV_ANY_ID.
> +    pub vendor: u32,
> +}
> +
> +// SAFETY: we ensure that `RawDeviceId::ZERO` is actually a zeroed out version of
> +// the raw device id. Offset is not needed, because there is no `data` pointer.
> +unsafe impl const crate::driver::RawDeviceId for DeviceId {
> +    type RawType = bindings::virtio_device_id;
> +
> +    const ZERO: Self::RawType = bindings::virtio_device_id {
> +        device: 0,
> +        vendor: 0,
> +    };
> +
> +    fn to_rawid(&self, _offset: isize) -> Self::RawType {
> +        bindings::virtio_device_id {
> +            device: self.device,
> +            vendor: self.vendor,
> +        }
> +    }
> +}
> +
> +/// Defines a VirtIO ID table consisting of [`DeviceId`] entries.
> +#[macro_export]
> +macro_rules! define_virtio_id_table {
> +    ($data_type:ty, $($t:tt)*) => {
> +        $crate::define_id_table!(ID_TABLE, $crate::virtio::DeviceId, $data_type, $($t)*);
> +    };
> +}
> +
> +/// A registration of a virtio driver.
> +pub type Registration<T> = driver::Registration<Adapter<T>>;
> +
> +/// An adapter for the registration of virtio drivers.
> +pub struct Adapter<T: Driver>(T);
> +
> +impl<T: Driver> driver::DriverOps for Adapter<T> {
> +    type RegType = bindings::virtio_driver;
> +
> +    unsafe fn register(
> +        reg: *mut bindings::virtio_driver,
> +        name: &'static CStr,
> +        _module: &'static ThisModule,
> +    ) -> Result {
> +        // SAFETY: By the safety requirements of this function `reg` is non-null
> +        // and valid.
> +        let virtio_driver = unsafe { &mut *reg };
> +
> +        virtio_driver.driver.name = name.as_char_ptr();
> +        virtio_driver.probe = Some(Self::probe_callback);
> +        virtio_driver.remove = Some(Self::remove_callback);
> +        if let Some(t) = T::ID_TABLE {
> +            virtio_driver.id_table = t.as_ref();
> +        }
> +
> +        to_result(unsafe { bindings::register_virtio_driver(reg) })

Please add a SAFETY comment here. And everywhere else you have an
`unsafe` block.

> +    }
> +
> +    unsafe fn unregister(reg: *mut bindings::virtio_driver) {
> +        // SAFETY: By the safety requirements of this function `reg` was passed
> +        // (and updated) by a previous successful call to
> +        // `register_virtio_driver`.
> +        unsafe { bindings::unregister_virtio_driver(reg) };
> +    }
> +}
> +
> +impl<T: Driver> Adapter<T> {
> +    extern "C" fn probe_callback(virtio_device: *mut bindings::virtio_device) -> core::ffi::c_int {
> +        from_kernel_result! {
> +            // SAFETY: `virtio_device` is valid by the contract with the C code.
> +            // `dev` is alive only for the duration of this call, so it is
> +            // guaranteed to remain alive for the lifetime of `virtio_device`.
> +            let mut dev = unsafe { Device::from_ptr(virtio_device) };
> +            if let Some(data) = T::probe(&mut dev)? {
> +                // SAFETY: `virtio_device` is passed in by the kernel and
> +                // assumed to be valid.
> +                unsafe { (*virtio_device).priv_ = data.into_foreign() as _ }
> +            }
> +
> +            // Either `probe()` or `device_ready()` must pass Self::Data, as we
> +            // assume `virtio_device.priv_` is set to a valid object throughout
> +            // the code.
> +            // SAFETY: `virtio_device` is passed in by the kernel and
> +            // assumed to be valid.
> +            if !(unsafe { *virtio_device }).priv_.is_null() {
> +                Ok(0)
> +            } else {
> +                Err(EINVAL)
> +            }

I think we should do this enforcement at compile time with the type
system. For example, we could have a type that allows a device to be
enabled: Enabler<'token>, which has two functions: `fn auto(self,
data: Self::Data) -> AutoEnable<'token, Self::Data>`, or `fn
manual(self, data: Self::Data) -> ManualEnable<'token>`.

Then the result of `probe` would be `Result<Either<AutoEnable<'token,
Self::Data>, ManualEnable<'token>>>`.

If we make `Enabler<'a>` invariant in `'a`, we can guarantee at
compile time that `probe` has three options:
1. Fail, returns Err(_).
2. Succeeds with "automatic" enablement (after probe), so probe
returns `AutoEnable`, which contains an instance of `Self::Data` to be
stored in ->priv.
3. Succeeds with "manual" enablement (during probe), so probe returns
`ManualEnable`, but no instance of `Self::Data` because one will
already have been stored in ->priv during manual enablement.

Both `ManualEnable` and `AutoEnable` can only be created from specific
instance of `Enabler` (due to the invariance of the lifetime). All
checked at compile time.

The `ManualEnable` type should also be the one that allows `probe` to
access virtqueues: since access isn't allowed in probe before enabling
the device.

> +        }
> +    }
> +
> +    // Note, this type is a wrapper over a kernel pointer, meaning that we
> +    // cannot be sure that the pointee is actually going away when the wrapper
> +    // is dropped. Thus, release resources here instead, since the kernel will
> +    // call this when the actual pointee is to be removed.
> +    extern "C" fn remove_callback(virtio_device: *mut bindings::virtio_device) {
> +        // SAFETY: `virtio_device` is guaranteed to be a valid, non-null
> +        // pointer. `priv_` was set on `probe()`.
> +        let ptr = unsafe { (*virtio_device).priv_ };
> +        // SAFETY:
> +        // - We allocated this pointer using `T::Data::into_foreign`, so it is
> +        //   safe to turn back into a `T::Data`.
> +        // - The allocation happened in probe()`, no-one freed the memory and
> +        //   `remove` is the canonical kernel location to free driver data. So,
> +        //   it is OK to convert the pointer back to a Rust structure here.
> +        let data = unsafe { T::Data::from_foreign(ptr) };
> +        T::remove(&data);
> +
> +        // SAFETY: just a couple of FFI call with a valid pointer.
> +        unsafe {
> +            bindings::virtio_del_vqs(virtio_device);
> +            bindings::virtio_reset_device(virtio_device);
> +        }
> +        <T::Data as driver::DeviceRemoval>::device_remove(&data);
> +    }
> +}
> +
> +/// A virtio driver.
> +pub trait Driver {
> +    /// Data stored on device by driver in `virtio_device.priv`
> +    type Data: ForeignOwnable + Send + Sync + driver::DeviceRemoval = ();
> +
> +    /// The table of [`DeviceId`]s supported by the driver.
> +    const ID_TABLE: Option<driver::IdTable<'static, DeviceId, ()>> = None;
> +    /// The virtio features offered. This depends on the specifics of the given
> +    /// VirtIO protocol for the device and can be empty.
> +    const FEATURES: &'static [i32] = &[];
> +
> +    /// VirtIO driver probe.
> +    ///
> +    /// Called when a new virtio device is added or discovered.
> +    /// Implementers should attempt to initialize the device here.
> +    fn probe(dev: &mut Device) -> Result<Option<Self::Data>>;
> +
> +    /// VirtIO driver remove.
> +    ///
> +    /// Called when a virtio device is removed.
> +    /// Implementers should prepare the device for complete removal here.
> +    ///
> +    /// In particular, implementers must ensure no buffers are left over in the
> +    /// virtqueues in use by calling [`virtqueue::get_buf()`] until `None` is
> +    /// returned.

What happens if implementers don't do this?

If this is a safety requirement, we need to find a different way to enforce it.

> +    fn remove(_data: &Self::Data) {}
> +}
> +
> +/// A VirtIO device.
> +///
> +/// # Invariants
> +///
> +/// The field `ptr` is non-null and valid for the lifetime of the object.
> +pub struct Device {
> +    ptr: *mut bindings::virtio_device,
> +}
> +
> +impl Device {
> +    /// Creates a new device from the given pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must be non-null and valid. It must remain valid for the lifetime of the returned
> +    /// instance.
> +    pub unsafe fn from_ptr(ptr: *mut bindings::virtio_device) -> Self {
> +        // INVARIANT: The safety requirements of the function ensure the lifetime invariant.
> +        Self { ptr }
> +    }
> +
> +    /// Returns id of the VirtIO device.
> +    pub fn id(&self) -> i32 {
> +        // SAFETY: By the type invariants, we know that `self.ptr` is non-null and valid.
> +        unsafe { (*self.ptr).id.device as _ }
> +    }
> +
> +    /// Returns the `Virtqueue` associated with `name`, if any.
> +    pub fn find_virtqueue<T: virtqueue::Operations>(
> +        &self,
> +        name: &CStr,
> +    ) -> Result<virtqueue::Virtqueue<T>> {
> +        let callback = if T::HAS_CALLBACK {
> +            Some(virtqueue::Virtqueue::<T>::vq_callback as _)
> +        } else {
> +            None
> +        };
> +
> +        // SAFETY: ptr is valid due to the type invariant, callback points to a
> +        // valid address and the pointer passed in is passed in by the kernel,
> +        // so it is assumed to be valid.
> +        let vq = unsafe { bindings::virtio_find_single_vq(self.ptr, callback, name.as_char_ptr()) };
> +        let vq = error::from_kernel_err_ptr(vq)?;
> +
> +        // SAFETY: vq is checked with `from_kernel_err_ptr`
> +        Ok(unsafe { virtqueue::Virtqueue::from_ptr(vq) })
> +    }
> +
> +    /// Returns the Virtio Device's private data.
> +    pub fn data<T: Driver>(&self) -> <T::Data as ForeignOwnable>::Borrowed<'_> {
> +        unsafe { <T::Data as ForeignOwnable>::borrow((*self.ptr).priv_) }
> +    }
> +
> +    /// Returns a pointer to the [`bindings::virtio_device`] associated with
> +    /// this [`Device`].
> +    pub fn raw_device(&self) -> *mut bindings::virtio_device {
> +        self.ptr
> +    }
> +
> +    /// Wrapper over the C-side `virtio_device_ready`. Enable virtqueue use in
> +    /// the probe function. Drivers must call this to use virtqueues in the
> +    /// probe function.
> +    ///
> +    /// `data` can be optionally be set through `device_ready()` instead of
> +    /// `probe()`.
> +    pub fn device_ready<T: Driver>(&self, data: Option<T::Data>) {
> +        if let Some(data) = data {
> +            // SAFETY: `virtio_device` is passed in by the kernel and
> +            // assumed to be valid.
> +            unsafe { (*self.ptr).priv_ = data.into_foreign() as _ }
> +        }
> +
> +        // SAFETY: just a FFI call on a valid pointer.
> +        unsafe {
> +            bindings::virtio_device_ready(self.ptr);
> +        }
> +    }
> +}
> +
> +// SAFETY: The device returned by `raw_device` is the raw virtio device.
> +unsafe impl device::RawDevice for Device {
> +    fn raw_device(&self) -> *mut bindings::device {
> +        // SAFETY: By the type invariants, we know that `self.ptr` is non-null and valid.
> +        unsafe { &mut (*self.ptr).dev }
> +    }
> +}
> +
> +/// Declares a kernel module that exposes a single virtio driver.
> +#[macro_export]
> +macro_rules! module_virtio_driver {
> +    ($($f:tt)*) => {
> +        $crate::module_driver!(<T>, $crate::virtio::Adapter<T>, { $($f)* });
> +    };
> +}
> diff --git a/rust/kernel/virtio/virtqueue.rs b/rust/kernel/virtio/virtqueue.rs
> new file mode 100644
> index 000000000000..a735f3d997a9
> --- /dev/null
> +++ b/rust/kernel/virtio/virtqueue.rs
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Virtqueue abstractions.
> +//!
> +//! C header: [`include/linux/virtio.h`](../../../../include/linux/virtio.h)
> +
> +use core::marker::PhantomData;
> +
> +use crate::error;
> +use crate::prelude::*;
> +use crate::scatterlist::Scatterlist;
> +use crate::virtio;
> +use crate::ForeignOwnable;
> +
> +/// The Virtqueue's operations.
> +#[vtable]
> +pub trait Operations: Sized {
> +    /// Data passed into the callback.
> +    type PrivateData: ForeignOwnable;
> +
> +    /// The virtqueue callback.
> +    fn callback(virtqueue: Virtqueue<Self>);
> +}
> +
> +/// A Virtqueue abstraction.
> +pub struct Virtqueue<T: Operations> {
> +    /// The underlying pointer.
> +    ptr: *mut bindings::virtqueue,
> +    /// A Phantom so T gets used.
> +    phantom: PhantomData<T>,
> +}
> +
> +impl<T: Operations> Virtqueue<T> {
> +    /// # Safety
> +    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
> +    /// returned [`Virtqueue`] instance.
> +    ///
> +    /// Caller must ensure that get_buf() returns None before the Virtqueue is
> +    /// dropped, so that ownership of the passed in T::PrivateData can be
> +    /// retrieved.
> +    pub unsafe fn from_ptr(ptr: *mut bindings::virtqueue) -> Self {
> +        Self {
> +            ptr,
> +            phantom: PhantomData,
> +        }
> +    }
> +
> +    /// A wrapper over the C side `virtqueue_add_sgs()`. Adds scatterlists to
> +    /// the [`Virtqueue`] for processing.
> +    pub fn add_sgs(
> +        &mut self,
> +        out_sgs: &mut [Scatterlist],
> +        in_sgs: &mut [Scatterlist],
> +        data: T::PrivateData,
> +        gfp: u32,
> +    ) -> Result {
> +        let mut sgs = Vec::new();
> +
> +        let num_out = out_sgs.len();
> +        let num_in = in_sgs.len();
> +
> +        for s in out_sgs {
> +            sgs.try_push(s.inner().get())?;
> +        }
> +        for s in in_sgs {
> +            sgs.try_push(s.inner().get())?;
> +        }
> +
> +        // SAFETY: `self.ptr` is valid as per the type invariant.
> +        let res = unsafe {
> +            bindings::virtqueue_add_sgs(
> +                self.ptr,
> +                sgs.as_mut_ptr(),
> +                num_out as u32,
> +                num_in as u32,
> +                data.into_foreign() as _,
> +                gfp,
> +            )
> +        };
> +
> +        error::to_result(res)
> +    }
> +
> +    /// A wrapper over the C side `virtqueue_kick()`. Notifies the VirtIO device
> +    /// of activity in this [`Virtqueue`].
> +    pub fn kick(&mut self) -> Result {
> +        let res = unsafe { bindings::virtqueue_kick(self.ptr) };
> +        error::to_result(res as i32)
> +    }
> +
> +    /// Returns the underlying [`virtio::Device`].
> +    pub fn virtio_device(&self) -> virtio::Device {
> +        // SAFETY: The virtio framework places a pointer to the VirtIO device
> +        // when creating the virtqueue
> +        unsafe { virtio::Device::from_ptr((*self.ptr).vdev) }
> +    }
> +
> +    /// A wrapper over the C side `virtqueue_get_buf()`. Returns the next used
> +    /// buffer, if any, alongside with the amount of data written.
> +    pub fn get_buf(&mut self) -> Option<(T::PrivateData, u32)> {
> +        let mut len = 0;
> +
> +        let data = unsafe {
> +            let buf = bindings::virtqueue_get_buf(self.ptr, &mut len as _);
> +
> +            if buf.is_null() {
> +                return None;
> +            }
> +
> +            // SAFETY: if there is a buffer token, it came from
> +            // `into_foreign()` as called in `add_sgs()`.
> +            <T::PrivateData as ForeignOwnable>::from_foreign(buf)
> +        };
> +
> +        Some((data, len))
> +    }
> +
> +    pub(crate) unsafe extern "C" fn vq_callback(vq: *mut bindings::virtqueue) {
> +        // SAFETY: the caller should guarantee that `vq` is valid for the lifetime
> +        // of `Self`.
> +        let virtqueue = unsafe { Self::from_ptr(vq) };
> +        T::callback(virtqueue);
> +    }
> +}
> +
> +unsafe impl<T: Operations> Send for Virtqueue<T> {}
> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> index 189c10ced6d4..0507c57170ec 100644
> --- a/samples/rust/Kconfig
> +++ b/samples/rust/Kconfig
> @@ -163,4 +163,14 @@ config SAMPLE_RUST_SELFTESTS
>
>           If unsure, say N.
>
> +config SAMPLE_RUST_VIRTIO
> +       tristate "Virtio"
> +       help
> +         This option builds the Rust virtio module sample.
> +
> +         To compile this as a module, choose M here:
> +         the module will be called rust_minimal.
> +
> +         If unsure, say N.
> +
>  endif # SAMPLES_RUST
> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> index 420bcefeb082..24059795480f 100644
> --- a/samples/rust/Makefile
> +++ b/samples/rust/Makefile
> @@ -15,5 +15,6 @@ obj-$(CONFIG_SAMPLE_RUST_NETFILTER)           += rust_netfilter.o
>  obj-$(CONFIG_SAMPLE_RUST_ECHO_SERVER)          += rust_echo_server.o
>  obj-$(CONFIG_SAMPLE_RUST_FS)                   += rust_fs.o
>  obj-$(CONFIG_SAMPLE_RUST_SELFTESTS)            += rust_selftests.o
> +obj-$(CONFIG_SAMPLE_RUST_VIRTIO)               += rust_virtio.o
>
>  subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)         += hostprogs
> diff --git a/samples/rust/rust_virtio.rs b/samples/rust/rust_virtio.rs
> new file mode 100644
> index 000000000000..fddab8674909
> --- /dev/null
> +++ b/samples/rust/rust_virtio.rs
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Rust virtio device driver sample. Retrieves a random number from the guest
> +//! using VirtIO Entropy.
> +
> +// impl_self_work_adapter!() does not compile otherwise.
> +#![allow(unreachable_code)]
> +
> +use kernel::bindings;
> +use kernel::module_virtio_driver;
> +use kernel::prelude::*;
> +use kernel::scatterlist;
> +use kernel::sync::smutex::Mutex;
> +use kernel::sync::Arc;
> +use kernel::sync::UniqueArc;
> +use kernel::virtio::virtqueue;
> +use kernel::virtio::virtqueue::Virtqueue;
> +use kernel::workqueue;
> +use kernel::Opaque;
> +
> +module_virtio_driver! {
> +    type: Driver,
> +    name: "rust_virtio",
> +    license: "GPL",
> +}
> +
> +struct AckWork {
> +    work: workqueue::Work,
> +    raw_dev: *mut kernel::bindings::virtio_device,
> +}
> +
> +impl AckWork {
> +    pub(crate) fn new(raw_dev: *mut kernel::bindings::virtio_device) -> Result<Arc<Self>> {
> +        let work = UniqueArc::try_new(Self {
> +            // SAFETY: init_work_item!() is called below
> +            work: unsafe { workqueue::Work::new() },
> +            raw_dev,
> +        })?;
> +
> +        kernel::init_work_item!(&work);
> +
> +        Ok(work.into())
> +    }
> +}
> +
> +kernel::impl_self_work_adapter!(AckWork, work, |w| {
> +    // SAFETY:
> +    //
> +    // If the work still exists, the driver data still exists (as it is its
> +    // sole owner).
> +    //
> +    // If the driver data still exisits, then the underlying kernel::Device
> +    // is alive (as it holds a reference obtained from get_device())
> +    //
> +    // If the contained struct device* is alive, the outermost struct
> +    // virtio_device* is presumed alive and valid.
> +    //
> +    // Other virtio drivers (in C) just use container_of here as they embed
> +    // the work struct in their driver struct itself.
> +    let virtio_dev = unsafe { kernel::virtio::Device::from_ptr(w.raw_dev) };
> +    let virtio_device_data = virtio_dev.data::<Driver>();
> +
> +    let mut vq = virtio_device_data.vq.lock();
> +
> +    if let Some(resp) = vq.get_buf() {
> +        pr_crit!("Retrieving response, host wrote {} bytes", resp.1);
> +        // SAFETY: Just a FFI call on a completion that was previously
> +        // initialized with `init_completion`.
> +        unsafe { bindings::complete(resp.0.completion.get()) }
> +    }
> +});
> +
> +// SAFETY: the fields are not exposed. Nothing can be done.
> +unsafe impl Send for AckWork {}
> +unsafe impl Sync for AckWork {}
> +
> +struct Request {
> +    inner: Mutex<RequestInner>,
> +    completion: Opaque<bindings::completion>,
> +}
> +
> +struct RequestInner {
> +    data: [u8; 64],
> +}
> +
> +fn send_request(
> +    vq: &Mutex<Virtqueue<VirtqueueCallback>>,
> +    request: <VirtqueueCallback as virtqueue::Operations>::PrivateData,
> +) -> Result {
> +    let mut inner_guard = request.inner.lock();
> +    // SAFETY: inner_guard.data points to an owned array, buflen is the size of
> +    // the array.
> +    let mut in_sgs = unsafe {
> +        [scatterlist::Scatterlist::init_one(
> +            inner_guard.data.as_mut_ptr() as *mut core::ffi::c_void,
> +            core::mem::size_of_val(&inner_guard.data) as u32,
> +        )]
> +    };
> +
> +    // SAFETY: Just a FFI call on a valid bindgen type.
> +    unsafe { bindings::init_completion(request.completion.get()) }
> +
> +    {
> +        let mut vq = vq.lock();
> +        let mut out_sgs = [];
> +        vq.add_sgs(
> +            &mut out_sgs[..],
> +            &mut in_sgs[..],
> +            Arc::clone(&request),
> +            bindings::GFP_KERNEL,
> +        )?;
> +
> +        vq.kick()?;
> +    }
> +
> +    pr_crit!("Request sent, waiting");
> +
> +    // SAFETY: Just a FFI call on a valid bindgen type that was previously
> +    // passed to `init_completion`.
> +    unsafe { bindings::wait_for_completion(request.completion.get()) }
> +
> +    pr_crit!("Request completed, response was {:?}", inner_guard.data);
> +    Ok(())
> +}
> +
> +struct Driver {
> +    /// The virtqueue.
> +    vq: Mutex<Virtqueue<VirtqueueCallback>>,
> +    /// The ack work that is awaken by the ack callback.
> +    work: Arc<AckWork>,
> +}
> +
> +impl kernel::driver::DeviceRemoval for Driver {
> +    fn device_remove(&self) {
> +        let mut vq = self.vq.lock();
> +        while let Some(_buf) = vq.get_buf() {
> +            // Actual drivers should take care to retrieve any left over buffers
> +            // so `T::PrivateData` can drop.
> +        }
> +    }
> +}
> +
> +impl kernel::virtio::Driver for Driver {
> +    type Data = Arc<Self>;
> +
> +    kernel::define_virtio_id_table! {(), [
> +         (kernel::virtio::DeviceId {
> +            device: bindings::VIRTIO_ID_RNG,
> +            vendor: bindings::VIRTIO_DEV_ANY_ID,
> +         }, None),
> +    ]}
> +
> +    fn probe(virtio_dev: &mut kernel::virtio::Device) -> Result<Option<Self::Data>> {
> +        pr_info!("rust_virtio: probing");
> +
> +        let vq = virtio_dev.find_virtqueue::<VirtqueueCallback>(kernel::c_str!("input"))?;
> +        let vq = Mutex::new(vq);
> +
> +        let work = AckWork::new(virtio_dev.raw_device())?;
> +        let data = Arc::try_new(Self { vq, work })?;
> +
> +        // We want to use the virtqueues here in this example.
> +        virtio_dev.device_ready::<Self>(Some(Arc::clone(&data)));
> +
> +        let request = Arc::try_new(Request {
> +            inner: Mutex::new(RequestInner { data: [0; 64] }),
> +            completion: Opaque::new(Default::default()),
> +        })?;
> +
> +        send_request(&data.vq, Arc::clone(&request))?;
> +
> +        pr_info!("rust_virtio probed succesfully!");
> +
> +        Ok(None)
> +    }
> +}
> +
> +pub(crate) struct VirtqueueCallback;
> +
> +#[vtable]
> +impl virtqueue::Operations for VirtqueueCallback {
> +    type PrivateData = Arc<Request>;
> +
> +    fn callback(vq: Virtqueue<Self>) {
> +        let vdev = vq.virtio_device();
> +        let data = vdev.data::<Driver>();
> +        let data = &*data;
> +
> +        pr_info!("virtqueue callback called successfully!");
> +
> +        // Enqueue work in order to retrieve the data and complete the
> +        // completion.
> +        kernel::workqueue::system().enqueue(Arc::clone(&data.work));
> +    }
> +}
> --
> 2.40.0
>
